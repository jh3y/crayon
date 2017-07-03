# crayon :sunglasses:
_a local development setup for styling your CodePen profile_

## The problem

Did you know that you can style your CodePen profile? You can!

It's __simple__. In your profile settings, you can apply the CSS from any pen to your profile by providing the URL in the options within "Settings > Customize".

```shell
https://codepen.io/you/settings/customize
```

However, that's easier said than done. You'll need to explore the markup and work out the styles you want to overwrite. This in addition to working on the styling pen whilst constantly refreshing your profile page to review the changes :confounded: :sleeping:

## The solution
This repo reduces the burden by allowing you to work with a local and generic version of a CodePen profile page. You're able to review your developed styling and get visual feedback in the browser with live reload goodness :smile: Once you're done, you can deploy the styling changes to CodePen from the command line using an automated "[POST to Prefill Editors](https://blog.codepen.io/documentation/api/prefill/)" setup.

## Usage
The repo uses a `Makefile` to process the source and deploy styles to CodePen.

To get started;

```shell
make setup
```

You can then use
```shell
make develop
```
to get underway with developing your styles.

Style source is located within `src/style`. The main point of entry being `src/style/style.styl`. The repo uses [`Stylus`](http://stylus-lang.com) as I find this to be a relatively flexible preprocessor that allows various syntax styles and should keep the majority happy.

Once you're happy with your styles, you can deploy them.
```shell
make deploy
```

__NOTE::__ _For deployment to work seamlessly, it is assumed you are on OSX and your default application for handling `.html` files is a browser and not an editor. If this is not the case, simply open `tmp/deploy-template.html` in the browser of your choice._


This will create a new pen in your browser containing your styling. Once this pen is saved, all that is left to do is linking it to your profile at https://codepen.io/you/settings/customize.

Enjoy! :sunglasses:

## Examples
* Your own styles?

## Contributing
Any issues or suggestions, feel free to open an issue or submit a PR. Alternatively, you can tweet me [@_jh3y](https://twitter.com/@_jh3y)

It would also be great if people could share their own styles/creativity to gather a curated list of example styles.
---
Made with :heart: by [@jh3y](https://twitter.com/_jh3y) 2016
