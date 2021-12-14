## Macaroon
Macaroon is a simple shell theme, especially for coder girls, designed with snow, mimi pink, water and pale lavender. Currently it supports [*oh-my-posh*](https://ohmyposh.dev/) (for *bash*/*zsh*/*pwsh*/*fish*/*nu*) and [*oh-my-zsh*](https://ohmyz.sh/) (for *zsh*). Hope you'll enjoy it ~ (\*^▽^)/★\*☆ 

## Preview

#### Oh My Posh

![](<posh.png>)

#### Oh My Zsh

![](<zsh.png>)

## Install

1. Click [here](https://github.com/ryanoasis/nerd-fonts) to download and install a nerd font, and then apply it to your terminal. 

2. Follow the steps below (Posh/Zsh, depending on your environment): 

   - ##### Oh My Posh
     
     > Some terminals don't support transparent foreground. You may see an annoying gray leading triangle in the powerline.  
     
     | Platform | Docs                                                         |
     | -------- | ------------------------------------------------------------ |
     | Linux    | [Official Tutorial](https://ohmyposh.dev/docs/linux#customize) |
     | Windows  | [Official Tutorial](https://ohmyposh.dev/docs/windows#customize) |
     | MacOS    | [Official Tutorial](https://ohmyposh.dev/docs/macos#customize) |
     
   - ##### Oh my Zsh
   
     > You may follow the steps below to install this theme. [Official Tutorial](https://github.com/ohmyzsh/ohmyzsh/wiki/Customization#overriding-and-adding-themes) is available also. 
   
     1. Download `./zsh/macaroon.zsh-theme`  and copy it to `~/.oh-my-zsh/custom/themes/` . 
     2. Open `~/.zshrc` and set `ZSH_THEME` to `"macaroon"`.
     3. Restart your shell or run `. ~/.zshrc`.
   
     ###### Enable the Forked Tail Style (Alternative)
   
     1. Run ` spectrum_ls` and find index of the color most similar to your terminal background.  
     2. Open `~/.zshrc` and add  `export ZSH_THEME_MACAROON_INIT_COLOR="INDEX"` in which `INDEX` should be replaced with the index you selected (e.g. `241`  for gray). 
     3. Restart your shell or run `. ~/.zshrc`.

## Help Wanted

[Lan](https://github.com/idyllan) is a newbie to Linux and English. It would be nice if you could correct grammatical mistakes or bugs in this repo.  Pull request and issue all are welcome ~ o(\*^▽^\*)o 

