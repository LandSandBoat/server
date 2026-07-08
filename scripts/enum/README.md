This directory is intended for enums attached to the xi global only.  Filenames
should correspond to the exact table it defines, where camelCase is replaced by camel_case.

All of these enums are cached on server startup before globals, and there is no need to include
these files as dependencies anywhere.

*This is not a catchall for every global enum, but only those that are not closely tied to code
in a specific file*
