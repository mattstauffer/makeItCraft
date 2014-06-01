makeItCraft
===========

Shell script to build out Craft install quickly. This is a geekier, more technical installer--see the [installation docs][1] for more installation options.

## Notes

 * The current version of this app is for Apache and chmods 774. To learn more about how to make this work with non-Apache servers, or to customize your Apache settings, check out the [docs][1]

## Instructions

1. Put [makeItCraft.sh][2] somewhere you can access it easily. Your home folder, maybe.
2. Make sure your permissions are set so it's executable: `chmod +x ~/makeItCraft.sh`
3. Create and cd into your directory (`mkdir my-new-site; cd my-new-site`)
4. Run makeItCraft `~/makeItCraft.sh`
5. Profit

## One-off Instructions
If you're a clever clogs, you could download, run, and then throw out makeItCraft directly in a single command:

```bash
\curl -sSL https://raw.githubusercontent.com/mattstauffer/makeItCraft/master/makeItCraft.sh | bash -s stable
```

You could even edit your `.bash_profile` or `.zshrc` to make this a powerful and simple shortcut:

```bash
alias makeItCraft="\curl -sSL https://raw.githubusercontent.com/mattstauffer/makeItCraft/master/makeItCraft.sh | bash -s stable"
```

Now you can just run `makeItCraft` anywhere on your command line. (Be sure to close and reopen your terminal first).

## GIF

![Animation showing installation process](https://raw.githubusercontent.com/mattstauffer/makeItCraft/master/make-it-craft.gif)

[1]: http://buildwithcraft.com/docs/installing
[2]: https://raw.githubusercontent.com/mattstauffer/makeItCraft/master/makeItCraft.sh