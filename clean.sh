#!/bin/bash

echo "Clean Your Git"

current_dir=$(pwd)
echo $current_dir
gitrepo=$1



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


workingDirectory="$current_dir/working-directory"
bin="$workingDirectory/bin"
src="$workingDirectory/src"

mkdir "$workingDirectory"
mkdir "$bin"
mkdir "$src"


curl -sSL -o git-sizer.zip "$download_url"
unzip git-sizer.zip -d "$bin/git-sizer"
rm -rf git-sizer.zip

gitSizer="$bin/git-sizer/git-sizer"
$gitSizer --version



if command -v git &>/dev/null; then
    git_version=$(git --version)
    echo "Git is installed. Version: $git_version"
else
    echo "Git is not installed Please install git."
fi
cd "$src"
ls
git clone --mirror $gitrepo "$src"

cd "$src"
$gitSizer -v > ../gitsizer.out
cat ../gitsizer.out


for commit in $(git rev-list --all); do
    for file in $(git ls-tree --long -r $commit | awk '{print $4" "$5}'); do
        size=$(echo $file | cut -d' ' -f1)
        if [[ $size =~ ^[0-9]+$ ]]
        then
             if [ $size -gt 52428800 ]
            then
                path=$(echo $file | cut -d' ' -f2-)
                echo "$commit,$path,$size" 
            fi
        fi
        
    done
done



cd "$current_dir"
rm -rf "working-directory"

