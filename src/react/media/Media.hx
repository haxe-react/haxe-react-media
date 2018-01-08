package react.media;

import haxe.extern.EitherType;
import js.Browser;
import js.html.MediaQueryList;
import react.Partial;
import react.React;
import react.ReactComponent;

// TODO: tools to make typed queries
typedef MediaQuery = String;

typedef MediaProps = {
	var query:MediaQuery;
	var children:EitherType<ReactElement, Bool->ReactElement>;
	@:optional var defaultMatches:Bool;
	@:optional var render:Void->ReactElement;
}

typedef MediaState = {
	var matches:Bool;
}

class Media extends ReactComponentOfPropsAndState<MediaProps, MediaState> {
	static var defaultProps:Partial<MediaProps> = {
		defaultMatches: true
	};

	var mediaQueryList:MediaQueryList;

	public function new(props:MediaProps) {
		super(props);
		state = {matches: props.defaultMatches};
	}

	override public function render() {
		if (props.render != null) {
			if (!state.matches) return null;
			return props.render();
		}

		if (Reflect.isFunction(props.children))
			return Reflect.callMethod(props, untyped props.children, [state.matches]);

		if (!state.matches || React.Children.count(props.children) < 1)
			return null;

		return React.Children.only(props.children);
	}

	override function componentWillMount() {
		mediaQueryList = Browser.window.matchMedia(props.query);
		mediaQueryList.addListener(updateMatches);
		updateMatches(null);
	}

	override function componentWillUnmount() {
		mediaQueryList.removeListener(updateMatches);
	}

	function updateMatches(_) {
		setState({matches: mediaQueryList.matches});
	}
}

