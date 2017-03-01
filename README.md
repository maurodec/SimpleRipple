# SimpleRipple

SimpleRipple is a an implementation of the Ripple Effect present in Material Design. It is implemented as a `UIView` extension so it should work out of the box without needing to subclass or implement anything at all.

Included in the code is a straightforward example that shows how to use it.

## Installation

If youre uing Cocoapods you can add it as a dependency like so:

```
pod 'SimpleRipple', :git => 'https://github.com/maurodec/SimpleRipple.git', :tag => 'v1.0.0'
```

You can replace `v1.0.0` with any version you want. If you're unsure about how to use Cocoapods with git I suggest you check out the [online help](https://guides.cocoapods.org/using/the-podfile.html#from-a-podspec-in-the-root-of-a-library-repo) which explains everything pretty well.

If you're not using Cocoapods you can simply download the `.h` and `.m` in [the SimpleRiplle directory](https://github.com/maurodec/SimpleRipple/tree/master/SimpleRipple).

## Usage

Using this library is, as the name implies, very simple.

1. Include the library in your project.

   ```
   #import "UIView+SimpleRipple.h"
   ```
2. Add the ripple effect to any `UIView`

   ```
   [sender rippleStartingAt:origin 
                  withColor:[UIColor colorWithWhite:0.0f alpha:0.20f] 
                   duration:duration 
                     radius:radius 
                  fadeAfter:fadeAfter];
   ```

If youre interested on how this was built (or just want to see gifs of what it looks like), you should read the [accompanying blog post](http://maurodec.com/blog/simple-ripple-effect-for-ios-views/).

## Contributing

If you find any bugs or want to improve the library, then please feel free to fork this repository and submit a pull request.
