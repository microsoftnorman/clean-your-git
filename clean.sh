#!/bin/bash

function installGitSizer(){
    os=$(uname -s)

    if [[ "$os" == "Darwin" ]]; then
        echo "Mac"
        download_url="https://github.com/github/git-sizer/releases/download/v1.5.0/git-sizer-1.5.0-darwin-amd64.zip"
    elif [[ "$os" == "Linux" ]]; then
        echo "Linux"
        download_url="https://github.com/github/git-sizer/releases/download/v1.5.0/git-sizer-1.5.0-linux-amd64.zip"
    elif [[ "$os" == "MINGW"* || "$os" == "MSYS"* || "$os" == "CYGWIN"* ]]; then
        echo "Windows"
        download_url="https://github.com/github/git-sizer/releases/download/v1.5.0/git-sizer-1.5.0-windows-amd64.zip"
    else
        echo "Unsupported OS"
        exit 1
    fi


    curl -sSL -o git-sizer.zip "$download_url"
    unzip git-sizer.zip -d "$bin/git-sizer"
    rm -rf git-sizer.zip

    git_sizer="$bin/git-sizer/git-sizer"
    $git_sizer --version
}

function checkForGit(){
    if command -v git &>/dev/null; then
        git_version=$(git --version)
        echo "Git is installed. Version: $git_version"
    else
        echo "Git is not installed Please install git."
    fi

}
function cleanYourGit(){
    local target_repo=$1
    local file_safe_name=$(echo "$target_repo" | sed 's/[^A-Za-z0-9]/_/g')
    echo $target_repo+"[]"
    cd "$src"
    git clone $target_repo "$file_safe_name" 
    cd "$src/$file_safe_name" 
    $git_sizer -v > "$output/$file_safe_name.gitsizer"

    git rev-list --objects --all \
    | git cat-file --batch-check='%(objecttype),%(objectname),%(objectsize),%(rest)' \
    | awk '/^blob/ {print substr($0,6)}' \
    | sort --numeric-sort --key=2 \
    | cut --complement --characters=13-40 \
    | numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest 
    #git gc --prune=now --aggressive
    rm -rf "$src/$file_safe_name"
}

echo "Clean Your Git"

current_dir=$(pwd)
echo $current_dir
output_directory=$2

target_repos=()
if [ -f "$1" ]; then
    while IFS= read -r line
    do
        target_repos+=("$line")
    done < "$1"
else
    target_repos+=("$1")
fi


working_directory="$current_dir/working-directory"
bin="$working_directory/bin"
src="$working_directory/src"
error="$current_dir/error"
output="$current_dir/output"
mkdir "$working_directory"
mkdir "$bin"
mkdir "$src"
mkdir "$error"
mkdir "$output"

installGitSizer
checkForGit

for i in "${target_repos[@]}"
do
    cleanYourGit "$i" &
done
wait

cd "$current_dir"
rm -rf "$working_directory"

 