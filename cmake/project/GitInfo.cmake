# xi_read_git_info(<source dir>): sets GIT_SHA1, GIT_BRANCH, GIT_DATE and GIT_COMMIT_SUBJECT,
# or "unknown" for each when there is no git or no repository (a source archive, say).
# Shared by Git.cmake at configure time and Version.cmake at build time.
function(xi_read_git_info source_dir)
    foreach(field SHA1 BRANCH DATE COMMIT_SUBJECT)
        set(GIT_${field} "unknown")
    endforeach()

    if(GIT_EXECUTABLE)
        set(GIT_SHA1_ARGS describe --match=NeVeRmAtCh --always --dirty)
        set(GIT_BRANCH_ARGS rev-parse --abbrev-ref HEAD)
        set(GIT_DATE_ARGS log -1 --format=%ad --date=local)
        set(GIT_COMMIT_SUBJECT_ARGS log -1 --format=%s)

        foreach(field SHA1 BRANCH DATE COMMIT_SUBJECT)
            execute_process(COMMAND "${GIT_EXECUTABLE}" ${GIT_${field}_ARGS}
                WORKING_DIRECTORY "${source_dir}"
                OUTPUT_VARIABLE value
                RESULT_VARIABLE result
                ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)
            if(result EQUAL 0 AND NOT value STREQUAL "")
                set(GIT_${field} "${value}")
            endif()
        endforeach()
    endif()

    # It lands in a C string literal.
    string(REPLACE "\\" "\\\\" GIT_COMMIT_SUBJECT "${GIT_COMMIT_SUBJECT}")
    string(REPLACE "\"" "'" GIT_COMMIT_SUBJECT "${GIT_COMMIT_SUBJECT}")

    foreach(field SHA1 BRANCH DATE COMMIT_SUBJECT)
        set(GIT_${field} "${GIT_${field}}" PARENT_SCOPE)
    endforeach()
endfunction()
