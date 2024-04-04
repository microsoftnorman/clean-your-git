# Git: A Version Control System

Git is a powerful tool that:

- Acts as a 'time machine' for your files, allowing you to revisit and restore previous versions.
- Facilitates collaboration by enabling multiple contributors to work on the same project without overwriting each other's changes.
- Enhances productivity and minimizes confusion by tracking changes and updates made to files over time.
- Is an essential tool for efficient and streamlined project management.
- Is the underlying code store for Azure DevOps and GitHub.

## Git's Challenges: Large Files and Binary Files

### 1. Large Files:

Git's structure can cause 'repository bloat' when dealing with large files, slowing down operations such as cloning and fetching. Each change saves the entire file, not just the differences, which can quickly eat up storage space, especially with frequent updates. Git Annex is a Git extension that enables version control of large files by storing their contents in separate locations, such as network storage or Azure files, rather than directly in the Git repository.


**Solution:** Tools like Git Large File Storage (LFS) help manage this issue. LFS replaces large files with text pointers within Git, storing the actual file contents on a remote server.

### 2. Binary Files:

Git's diff algorithm is designed for text files, struggling with binary files that aren't line-based. Once committed, binary files live in Git's history forever, inflating repository size—this problem grows if binary files are often modified. Merge conflicts with binary files are tricky to resolve and typically need manual intervention.

**Solution:** Artifact storage tools like Artifactory, Azure Artifacts, GitHub Releases, and Azure Container Storage provide alternatives for managing binary files. Traditional file systems can also be a viable workaround.

### 3. Binary Files are often Large Files

## Clean Up Your Git

Here are some strategies to keep your Git repositories clean and efficient:

- **Remove Unnecessary Files:** Use the `git rm` command to delete any unnecessary or large files that are no longer needed in your repository.
- **Ignore Unnecessary Files:** Use a `.gitignore` file to specify which files and directories Git should ignore when committing changes.
- **Use `git gc` Command:** The `git gc` command cleans up unnecessary files and optimizes your repository.
- **Shrink Repository with `git prune`:** This command removes objects that are no longer pointed to by any branch or tag. Check out the [git prune documentation](https://git-scm.com/docs/git-prune).
- **Remove Old Commits with `git rebase`:** The `git rebase` command can be used to modify your commit history.
- **Use `git clone --depth 1`:** If you're cloning a repository and only need the latest version of the files, you can use the `--depth` option.
- **Remove Large Files with BFG Repo-Cleaner:** The BFG Repo-Cleaner is a tool that can quickly find and remove large files in your Git repository.
- **Use git-sizer:** It is a tool to compute various size metrics for a Git repository, flagging those that might cause problems. You can find it on [GitHub](https://github.com/github/git-sizer).
- **Avoid Storing Large Binary Files:** Git is not well-suited for handling large binary files, which can significantly increase the size of your repository. Consider using a service like Git LFS (Large File Storage) for managing and versioning large files.
- **Clean Up Old References:** By running `git remote prune origin`, you can clean up old references that are no longer valid on the remote repository.
- **Use `git reflog expire`:** The `git reflog expire` command can be used to expire old entries in your reflog, which can help reduce the size of your repository.
- **Use Shallow Clone:** If you don't need the full history, create a shallow clone with a limited history using the `--depth` option in the `git clone` command.
- **Use Sparse Checkout:** Git 2.25 introduced the sparse-checkout feature which allows you to checkout only a subset of your repository.
- **Use `git archive`:** If you only need a snapshot of your repository, consider using the `git archive` command to create an archive of your repository.
- **Split the Repository:** If your repository has many large files that are rarely used, consider splitting the repository into smaller ones, each containing relevant parts of the code.
- **Use `git clean`:** The `git clean` command removes untracked files from your working directory. This can be useful to clear out generated files or build artefacts that may be taking up space.
- **Use `git filter-branch`:** `git filter-branch` is a powerful command that can be used to remove data from your entire Git history.
- **Use Squash Merges:** When merging branches, consider using squash merges to reduce the number of individual commits in your history, which can help reduce your repository size.
- **Compress Images:** If your repository contains images, consider compressing them to reduce their file size without significant loss of quality.
- **Delete Old Branches:** Old branches that have been merged and are no longer in use should be deleted with the `git branch -d` command. Remember, you can always restore a deleted branch if you need it later.
- **Don't Store Build Artifacts in Git:** Large binary files can significantly increase the size of your repository. Instead, consider using Azure Artifacts, GitHub Artifacts, or Artifactory to store these files.
- **Ship Your Test Artifacts:**  Large binary files can significantly increase the size of your repository. Instead, consider using Azure Artifacts, GitHub Artifacts, or Artifactory to store these files.

## Use Git Sizer

[Git Sizer](https://github.com/github/git-sizer) is a useful tool that calculates various size metrics for a Git repository and helps identify those that could potentially cause problems. With Git Sizer, you can evaluate the complexity and size of your repository, including branch count, tag count, largest blob, and more. It's designed to help you understand the 'big picture' of your repository's state. It can be a valuable resource to keep your repository manageable and optimized.

A big thanks to the team at [Git Sizer](https://github.com/github/git-sizer) for their invaluable work!

## How Do Use This Script
This is a wrapper for Git Sizer that will install and run on your local repo
Run the following command in your bash terminal to clean your Git repository:

```bash
./clean.sh https://github.com/nginx/nginx.git


