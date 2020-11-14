/*
===========================================================================
Copyright (c) Athena Dev Teams - Licensed under GNU G
===========================================================================
*/

#ifndef _SHOWMSG_H_
#define _SHOWMSG_H_

#include "../common/cbasetypes.h"
#include "fmt/printf.h"
#include <string>

/************************************************************************
*                                                                       *
*  for help with the console colors look here:                          *
*                                                                       *
*  http://www.edoceo.com/liberum/?doc=printf-with-color                 *
*                                                                       *
*  some code explanation (used here):                                   *
*                                                                       *
*  \033[2J : clear screen and go up/left (0, 0 position)                *
*  \033[K  : clear line from actual position to end of the line         *
*  \033[0m : reset color parameter                                      *
*  \033[1m : use bold for font                                          *
*                                                                       *
************************************************************************/

#define CL_RESET        "\033[0m"
#define CL_CLS          "\033[2J"
#define CL_CLL          "\033[K"

// font settings

#define CL_BOLD         "\033[1m"
#define CL_NORM         CL_RESET
#define CL_NORMAL       CL_RESET
#define CL_NONE         CL_RESET

// foreground color and bold font (bright color on windows)

#define CL_WHITE        "\033[1;37m"
#define CL_GRAY         "\033[1;30m"
#define CL_RED          "\033[1;31m"
#define CL_GREEN        "\033[1;32m"
#define CL_YELLOW       "\033[1;33m"
#define CL_BLUE         "\033[1;34m"
#define CL_MAGENTA      "\033[1;35m"
#define CL_CYAN         "\033[1;36m"

// background color

#define CL_BG_BLACK     "\033[40m"
#define CL_BG_RED       "\033[41m"
#define CL_BG_GREEN     "\033[42m"
#define CL_BG_YELLOW    "\033[43m"
#define CL_BG_BLUE      "\033[44m"
#define CL_BG_MAGENTA   "\033[45m"
#define CL_BG_CYAN      "\033[46m"
#define CL_BG_WHITE     "\033[47m"

// foreground color and normal font (normal color on windows)

#define CL_LT_BLACK     "\033[0;30m"
#define CL_LT_RED       "\033[0;31m"
#define CL_LT_GREEN     "\033[0;32m"
#define CL_LT_YELLOW    "\033[0;33m"
#define CL_LT_BLUE      "\033[0;34m"
#define CL_LT_MAGENTA   "\033[0;35m"
#define CL_LT_CYAN      "\033[0;36m"
#define CL_LT_WHITE     "\033[0;37m"

// foreground color and bold font (bright color on windows)

#define CL_BT_BLACK     "\033[1;30m"
#define CL_BT_RED       "\033[1;31m"
#define CL_BT_GREEN     "\033[1;32m"
#define CL_BT_YELLOW    "\033[1;33m"
#define CL_BT_BLUE      "\033[1;34m"
#define CL_BT_MAGENTA   "\033[1;35m"
#define CL_BT_CYAN      "\033[1;36m"
#define CL_BT_WHITE     "\033[1;37m"

#define CL_WTBL         "\033[37;44m"       // white on blue
#define CL_XXBL         "\033[0;44m"        // default on blue
#define CL_PASS         "\033[0;32;42m"     // green on green

#define CL_SPACE        "           "       // space equivalent of the print messages

extern int32 stdout_with_ansisequence;      // If the color ansi sequences are to be used. [flaviojs]
extern int32 msg_silent;                    // Specifies how silent the console is. [Skotlex]
extern char timestamp_format[20];           // For displaying Timestamps [Skotlex]

enum MSGTYPE
{
    MSG_NONE        = 0x0001,
    MSG_STATUS      = 0x0002,
    MSG_INFORMATION = 0x0004,
    MSG_NOTICE      = 0x0008,
    MSG_WARNING     = 0x0010,
    MSG_DEBUG       = 0x0020,
    MSG_ERROR       = 0x0040,
    MSG_FATALERROR  = 0x0080,
    MSG_SQL         = 0x0100,
    MSG_LUASCRIPT   = 0x0200,
    MSG_NAVMESH     = 0x0400,
    MSG_ACTION      = 0x0800,
    MSG_EXPLOIT     = 0x1000
};

void ClearScreen(void);

void InitializeLog(std::string logFile);
int32 _vShowMessage(MSGTYPE, const std::string&);

template<typename... Args>
int32 ShowMessage(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return _vShowMessage(MSG_NONE, fmt_string_v);
}

template<typename... Args>
int32 ShowStatus(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return _vShowMessage(MSG_STATUS, fmt_string_v);
}

template<typename... Args>
int32 ShowSQL(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return _vShowMessage(MSG_SQL, fmt_string_v);
}

template<typename... Args>
int32 ShowInfo(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return _vShowMessage(MSG_INFORMATION, fmt_string_v);
}

template<typename... Args>
int32 ShowNotice(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return _vShowMessage(MSG_NOTICE, fmt_string_v);
}

template<typename... Args>
int32 ShowWarning(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return _vShowMessage(MSG_WARNING, fmt_string_v);
}

template<typename... Args>
int32 ShowDebug(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return _vShowMessage(MSG_DEBUG, fmt_string_v);
}

template<typename... Args>
int32 ShowError(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return _vShowMessage(MSG_ERROR, fmt_string_v);
}

template<typename... Args>
int32 ShowFatalError(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return _vShowMessage(MSG_FATALERROR, fmt_string_v);
}

template<typename... Args>
int32 ShowScript(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return _vShowMessage(MSG_LUASCRIPT, fmt_string_v);
}

template<typename... Args>
int32 ShowNavError(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return _vShowMessage(MSG_NAVMESH, fmt_string_v);
}

template<typename... Args>
int32 ShowAction(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return _vShowMessage(MSG_ACTION, fmt_string_v);
}

template<typename... Args>
int32 ShowExploit(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return _vShowMessage(MSG_EXPLOIT, fmt_string_v);
}

#endif /* _SHOWMSG_H_ */
