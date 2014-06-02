makeItCraft
===========

Make It Craft is a command-line shell script that makes it extremely simple to get a CraftCMS install downloaded quickly. This is a geekier, more technical installer--see the [installation docs][1] for more installation options.

## Notes

 * The current version of this installer is for Apache and chmods 774. To learn more about how to make this work with non-Apache servers, or to customize your Apache settings, check out the [docs][1].
 * The current verison of this installer does not create your database or set up your hosts file. It just downloads your files and `chmods` them. The rest is up to you. 

## Instructions - local copy

1. Download [makeItCraft.sh][2] and place it somewhere you can access it easily from your Terminal. Consider your home folder (`~/`)
2. Make sure your permissions are set so it's executable: `chmod +x ~/makeItCraft.sh`
3. Create and CD into a directory for your new site (`mkdir my-new-site; cd my-new-site`)
4. Run makeItCraft `~/makeItCraft.sh`
5. That's it! You now have all your files downloaded.

## Instructions - alias
__DON'T USE THIS alias VERSION AT THE MOMENT. A bug in the way Curl handles Y/N prompts is making this version unusable. :(__

The easiest way to run the installer is to just create a blank directory for your new site, CD into it, and then copy the following line and run it from your terminal.

```bash
\curl -sSL https://raw.githubusercontent.com/mattstauffer/makeItCraft/master/makeItCraft.sh | bash
```

You could even add that line as an "alias" to your shell. Edit your `~/.bash_profile` (or `~/.zshrc` if you use Zsh) and add this line at the bottom to make this a powerful and simple shortcut:

```bash
alias makeItCraft="\curl -sSL https://raw.githubusercontent.com/mattstauffer/makeItCraft/master/makeItCraft.sh | bash -s stable"
```

Now close `~/.bash_profile` and restart your terminal window. You can now CD into your new directory, and run the command `makeItCraft`. That's it!

Here are the steps for a new site, once you've added this alias:

```bash
$ cd Sites
$ mkdir my-new-site
$ cd my-new-site
$ makeItCraft
```

That's it!


## GIF

![Animation showing installation process](https://raw.githubusercontent.com/mattstauffer/makeItCraft/master/make-it-craft.gif)

[1]: http://buildwithcraft.com/docs/installing
[2]: https://raw.githubusercontent.com/mattstauffer/makeItCraft/master/makeItCraft.sh
