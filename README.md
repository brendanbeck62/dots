# Dots
Literally just my configuration files

## adobe

### illustrator
macos location:
```
~/Library/Preferences/Adobe Illustrator 28 Settings/en_US/Workspaces
```

Windows location:
```
C:\Users\chick\AppData\Roaming\Adobe\Adobe Illustrator 29 Settings\en_US\x64\Workspaces
```

## ahk
Make sure that AHK is installed

## iterm
A note on setting a theme (in this case gruvbox)
- Vim
    - add a custom vim theme to `~/.vim/colors/theme.vim` something like [this](https://github.com/morhetz/gruvbox/blob/master/colors/gruvbox.vim)
    - add the following to your .vimrc:
    ```
        colorscheme gruvbox " sets the theme
        set termguicolors   " maybe not needed idk (kinda discussed here: https://stackoverflow.com/questions/44164518/themes-in-iterm-change-colours-in-vim)
    ```

- iTerm:
    - Find a .itermColors file like [this](https://github.com/shreyas-segu/gruvbox-dark-hard-iterm2/blob/main/GruvboxHardDark.itermcolors), and set it using the import function of the profile editor.

The problem I ran into is that everyone's implentation differs slightly between vscode, vim, iterm so its jaring to switch between them. Maybe one day but for now I am just going to stick to my defaults

Update: https://github.com/tinted-theming/home

## Stylus
Chrome extension that injects custom css
https://chromewebstore.google.com/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne

