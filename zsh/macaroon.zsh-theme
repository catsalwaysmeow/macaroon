# foreground: 
#    text
#   100e23
style_fore_text=233

# background: 
#     os     user@host   path   [git]   [error]
#   fff9fa   facee5     cbfafa  e8cbfa  ffc6bf
style_back_os=231
style_back_user_at_host=225
style_back_path=195
style_back_git=183
style_back_error=224

# icons:
icon_nerd_git_branch=$(echo -n "\ue0a0")
icon_nerd_triangle_right=$(echo -n "\ue0b0")
icon_nerd_dir_splitter=$(echo -n "\ue0b1")
icon_nerd_dir_home=$(echo -n "\uf015")
icon_nerd_dir_opend=$(echo -n "\uf115")
icon_nerd_os_windows=$(echo -n "\ue62a")
icon_nerd_os_macos=$(echo -n "\ue711")
icon_nerd_os_linux=$(echo -n "\ue712")
icon_nerd_os_unknown=$(echo -n "\ue7a2")


# Build a single powerline section. 
# A powerline looks like a fish: >==>
# This function prompts '>' (tail) and '==' (body), 
# because the 'tail' denotes both the head of last powerline and the tail of this powerline. 
# [$1]: background of last powerline
# [$2]: background of this powerline
# [$3]: foreground of this powerline
# [$4]: text
# $5: tail icon
function write_powerline() {
    local tail body

    # tail/head
    tail=""
    if [ $1 ]; then
        tail="%F{$1}"$tail
    fi
    if [ $2 ]; then
        tail=$tail"%K{$2}"
    fi
    tail=$tail$5
    
    # body
    body=" "
    if [ $3 ]; then
        body="%F{$3}$4"
    fi

    # write tail and body. 
    echo -n -e $tail$body"%{%k%}%{%f%}"
}


#
# Powerline sections. 
# For every function named prompt_*:
#   Target: Print a single powerline with respect to specified content. 
#   Responsibility: Update $last_bg_color as it's background color. 
#   Args: 
#     $last_bg_color: The background color of the last printed powerline section. 

function prompt_os() {
    local os_icon=""
    
    case "$(uname -s)" in
    Darwin)
        os_icon=$icon_nerd_os_macos
        ;;
    Linux)
        os_icon=$icon_nerd_os_linux
        ;;
    CYGWIN*|MINGW32*|MSYS*|MINGW*)
        os_icon=$icon_nerd_os_windows
        ;;
    *)
        os_icon=$icon_nerd_os_unknown
        ;;
    esac

    write_powerline $last_bg_color $style_back_os $style_fore_text " $os_icon " $icon_nerd_triangle_right
    last_bg_color=$style_back_os
}

function prompt_user_at_host() {
    write_powerline $last_bg_color $style_back_user_at_host $style_fore_text ' %n@%m ' $icon_nerd_triangle_right
    last_bg_color=$style_back_user_at_host
}

function prompt_path() {
    local working_dir=$(dirs -c; dirs)
    
    if [[ $working_dir =~ ^\/.* ]] {
        working_dir=$(echo -n $working_dir | sed "s/^\///") # root
    } elif [[ $working_dir =~ ^~.* ]] {
        working_dir="${working_dir/\~/$icon_nerd_dir_home}" # home
    }

    # non-leaf dirs
    working_dir=$(echo -n $working_dir | sed -r "s/[^\/$icon_nerd_dir_home]+\//$icon_nerd_dir_opend $icon_nerd_dir_splitter /g")
    
    # adjust home 
    working_dir="${working_dir/\// $icon_nerd_dir_splitter }"

    write_powerline $last_bg_color $style_back_path $style_fore_text " $working_dir " $icon_nerd_triangle_right
    last_bg_color=$style_back_path
}

function prompt_git_branch() {
    local branch
    
    ZSH_THEME_GIT_PROMPT_PREFIX=$icon_nerd_git_branch
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    branch=$(git_prompt_info)

    if [ -z $branch ]; then
        return
    fi

    write_powerline $last_bg_color $style_back_git $style_fore_text " $branch " $icon_nerd_triangle_right
    last_bg_color=$style_back_git
}

function prompt_error() {
    if [[ $LAST_EXECUTION_CODE == 0 ]]; then
        return
    fi
    write_powerline $last_bg_color $style_back_error $style_fore_text " $LAST_EXECUTION_CODE " $icon_nerd_triangle_right
    last_bg_color=$style_back_error
}

function prompt_end() {
    write_powerline $last_bg_color "" "" "" $icon_nerd_triangle_right
}


#
# Invoke powerline sections. 
function powerlines() {
    LAST_EXECUTION_CODE="$?"

    local prompts=("prompt_os" "prompt_user_at_host" "prompt_path" "prompt_git_branch" "prompt_error" "prompt_end")
    local last_bg_color=$ZSH_THEME_MACAROON_INIT_COLOR

    if [ -z $last_bg_color ]; then
        last_bg_color=$style_back_os
    fi

    for prompt in $prompts; do
        $prompt
    done

    echo -n " "
}


# 
# The prompt sequence: 
PROMPT='$(powerlines)'