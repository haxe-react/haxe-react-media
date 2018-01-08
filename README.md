# Haxe react media

A haxe-only version of the
[`react-media`](https://www.npmjs.com/package/react-media) npm package, a CSS
media query component for React..

A `<Media>` component listens for matches to a CSS media query and renders
stuff based on whether the query matches or not.

## Getting Started

### Installing

```
haxelib install react-media
```

No need for the npm package, this version is haxe-only.

### Usage with React

```haxe
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.media.Media;

class MyComponent extends ReactComponent {
	override public function render() {
		return jsx('
			<div>
				<$Media query="(min-width: 42em)">
					<p>The answer</p>
				</$Media>
			</div>
		');
	}
}
```

See [React-Training/react-media](https://github.com/ReactTraining/react-media)
for more documentation.
