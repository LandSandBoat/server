#ifdef _WIN32
#include "debug.h"
#include "logging.h"

#include "WheatyExceptionReport.h"

WheatyExceptionReport g_WheatyExceptionReport;

void debug::init()
{
    g_WheatyExceptionReport = WheatyExceptionReport();
}

bool debug::isRunningUnderDebugger()
{
    return IsDebuggerPresent();
}

void debug::reportSystemLocale()
{
    WCHAR localeName[LOCALE_NAME_MAX_LENGTH] = { 0 };

    if (GetSystemDefaultLocaleName(localeName, LOCALE_NAME_MAX_LENGTH) == 0)
    {
        ShowError("Failed to get system default locale name.");
        return;
    }

    char narrowLocaleName[LOCALE_NAME_MAX_LENGTH];
    WideCharToMultiByte(CP_UTF8, 0, localeName, -1, narrowLocaleName, LOCALE_NAME_MAX_LENGTH, NULL, NULL);

    ShowInfo("System's Default Locale: %s", narrowLocaleName);

    if (GetUserDefaultLocaleName(localeName, LOCALE_NAME_MAX_LENGTH) == 0)
    {
        ShowError("Failed to get user default locale name.");
        return;
    }

    WideCharToMultiByte(CP_UTF8, 0, localeName, -1, narrowLocaleName, LOCALE_NAME_MAX_LENGTH, NULL, NULL);

    ShowInfo("User's Default Locale: %s", narrowLocaleName);

    LANGID sysLangId = GetSystemDefaultLangID();

    WCHAR sysLangName[LOCALE_NAME_MAX_LENGTH] = { 0 };
    if (LCIDToLocaleName(MAKELCID(sysLangId, SORT_DEFAULT), sysLangName, LOCALE_NAME_MAX_LENGTH, 0) == 0)
    {
        ShowError("Failed to convert system language ID to locale name.");
        return;
    }

    char narrowSysLangName[LOCALE_NAME_MAX_LENGTH];
    WideCharToMultiByte(CP_UTF8, 0, sysLangName, -1, narrowSysLangName, LOCALE_NAME_MAX_LENGTH, NULL, NULL);

    ShowInfo("System's Default Language: %s", narrowSysLangName);

    LANGID userLangId = GetUserDefaultLangID();

    WCHAR userLangName[LOCALE_NAME_MAX_LENGTH] = { 0 };
    LCIDToLocaleName(MAKELCID(userLangId, SORT_DEFAULT), userLangName, LOCALE_NAME_MAX_LENGTH, 0);

    char narrowUserLangName[LOCALE_NAME_MAX_LENGTH];
    WideCharToMultiByte(CP_UTF8, 0, userLangName, -1, narrowUserLangName, LOCALE_NAME_MAX_LENGTH, NULL, NULL);

    ShowInfo("User's Default Language ID: %s", narrowUserLangName);
}
#endif // _WIN32
