# GitHub Copilot Instructions for clean-your-git

## Project Overview

This repository provides a Bash script wrapper for [Git Sizer](https://github.com/github/git-sizer) to analyze Git repository size metrics and help identify potential issues. The tool clones target repositories, runs Git Sizer, and generates reports on blob sizes and repository health.

## Project Context

- **Purpose**: Automate Git repository analysis using Git Sizer to help users understand repository bloat, large files, and optimization opportunities
- **Primary Language**: Bash scripting
- **Key Dependencies**: Git, Git Sizer, curl, unzip, standard Unix utilities
- **Target Platforms**: Linux, macOS, Windows (via Git Bash/MINGW/MSYS/Cygwin)
- **License**: MIT

## Coding Standards and Style Guidelines

### Bash Scripting Conventions

1. **Shebang**: Always use `#!/bin/bash` for Bash scripts
2. **Function Definitions**: Use the `function` keyword for clarity (e.g., `function functionName()`)
3. **Variable Naming**:
   - Use lowercase with underscores for local variables (e.g., `target_repo`, `file_safe_name`)
   - Use descriptive names that clearly indicate purpose
4. **Quoting**: Always quote variables to prevent word splitting (e.g., `"$variable"`)
5. **Error Handling**:
   - Check command availability with `command -v` before using
   - Exit with appropriate error codes on failures
   - Provide informative error messages
6. **Command Substitution**: Use `$(command)` syntax instead of backticks
7. **Conditionals**: Use `[[ ]]` for test conditions (modern Bash syntax)
8. **Portability**: Support Linux, macOS, and Windows (Git Bash) environments

### Code Organization

- Keep functions focused on single responsibilities
- Place utility functions before main execution logic
- Create working directories under a consistent structure
- Clean up temporary directories and files after execution

## Documentation Expectations

### README Updates

- Keep the README.md informative and up-to-date with:
  - Clear project description and purpose
  - Installation instructions
  - Usage examples with commands
  - Prerequisites and dependencies
  - Platform-specific notes

### Code Comments

- Add comments for complex logic or non-obvious operations
- Document function purposes with brief descriptions
- Avoid obvious comments that simply restate the code
- Use inline comments sparingly, only when necessary for clarity

### Inline Documentation

- Keep existing documentation style consistent
- Update documentation when making functional changes
- Maintain the educational tone of the README (explaining Git concepts)

## Architecture and Patterns

### Script Structure

1. **Function Definitions**:
   - `installGitSizer()`: Downloads and installs Git Sizer for the detected OS
   - `checkForGit()`: Verifies Git installation
   - `cleanYourGit()`: Main analysis function for a single repository

2. **Execution Flow**:
   - Setup working directories (bin, src, error, output)
   - Install Git Sizer
   - Process repositories (from file or single URL)
   - Parallel execution using background jobs (`&` and `wait`)
   - Cleanup temporary directories

3. **Directory Structure**:
   ```
   working-directory/
   ├── bin/          # Git Sizer binary
   └── src/          # Cloned repositories (temporary)
   output/           # Analysis results
   error/            # Error logs
   ```

### Key Design Decisions

- **Parallel Processing**: Multiple repositories are analyzed concurrently using `&` and `wait`
- **OS Detection**: Uses `uname -s` to determine platform and download appropriate Git Sizer binary
- **Safe Naming**: Converts repository URLs to filesystem-safe names using `sed`
- **Clean Slate**: Removes working directory after completion to avoid disk bloat

## Testing Requirements

### Manual Testing

When making changes to the script:

1. **OS Compatibility**: Test on different platforms (Linux, macOS, Windows Git Bash)
2. **Input Validation**: Test with both single URL and file input
3. **Error Scenarios**: Test with invalid URLs, missing dependencies, network failures
4. **Cleanup**: Verify working directories are properly removed after execution

### Test Cases

- Single repository analysis
- Multiple repositories from input file
- Invalid repository URLs
- Missing Git installation
- Network connectivity issues
- Permission issues with directory creation

### GitHub Actions

- The repository has a GitHub Actions workflow (`.github/workflows/blank.yml`)
- Changes should not break the existing workflow
- Test workflow changes in a branch before merging

## Common Operations

### Adding New Features

1. **Ask clarifying questions** before implementing changes to ensure alignment with project goals
2. Maintain backward compatibility with existing usage patterns
3. Follow existing function structure and naming conventions
4. Update README.md with new features or options
5. Test on multiple platforms when possible

### Bug Fixes

1. Identify the root cause before proposing a fix
2. Ensure fixes don't introduce regressions
3. Add comments explaining the fix if the issue was subtle
4. Update documentation if the bug was related to usage

### Refactoring

1. Keep changes minimal and focused
2. Preserve existing functionality
3. Improve readability without changing behavior
4. Test thoroughly after refactoring

## Dependencies and Tools

### Required Tools

- **Git**: Version control system (required)
- **Git Sizer**: Repository analysis tool (auto-installed by script)
- **curl**: For downloading Git Sizer
- **unzip**: For extracting Git Sizer archive
- **Standard Unix utilities**: awk, sed, sort, cut, numfmt

### Adding New Dependencies

- Minimize external dependencies
- Check for tool availability before use
- Provide clear error messages if tools are missing
- Document new dependencies in README.md

## File Structure and Conventions

### Repository Files

- `clean.sh`: Main script (executable)
- `input.txt`: Example input file with repository URLs
- `README.md`: Project documentation
- `.github/workflows/`: GitHub Actions workflows
- `.github/copilot-instructions.md`: This file

### Output Files

- `{repo_name}.gitsizer`: Git Sizer analysis output
- Generated in `output/` directory (created by script)

## Clarifying Questions Policy

**Always ask clarifying questions before making significant changes**, including:

- New features or functionality changes
- Breaking changes to existing behavior
- Changes that affect multiple platforms
- Modifications to the core analysis logic
- Changes to output format or directory structure

For minor changes (typo fixes, documentation updates, minor refactoring), use your best judgment.

## Best Practices

1. **Security**: Never commit sensitive data (credentials, tokens, private repository URLs)
2. **Performance**: Consider performance implications when processing multiple large repositories
3. **Error Messages**: Provide actionable error messages that help users diagnose issues
4. **Cleanup**: Always clean up temporary files and directories
5. **Idempotency**: Script should be safe to run multiple times
6. **Exit Codes**: Use appropriate exit codes for different failure scenarios
7. **Logging**: Output should be clear and help users understand what's happening

## Project Maintenance

- Keep Git Sizer version updated (version is defined in `clean.sh` lines 8, 11, and 14 - currently v1.5.0)
- Monitor for deprecated Bash features
- Ensure compatibility with latest Git versions
- Update README with new Git cleanup strategies as they become available

## Additional Notes

- The project focuses on educational content about Git repository management
- The README contains valuable information about Git's challenges with large and binary files
- Maintain the balance between tool functionality and educational content
