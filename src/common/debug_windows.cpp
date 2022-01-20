#include "debug.h"

#include "cbasetypes.h"
#include "logging.h"
#include "spdlog/fmt/fmt.h"
#include "version.h"

#define _NO_CVCONST_H
#include <DbgHelp.h>
#include <Psapi.h>
#include <Shlwapi.h>
#include <Windows.h>

#include <filesystem>
#include <string>
#include <vector>

namespace
{
    time_point StartUpTime = server_clock::now();
    uint8 CrashDepth = 0U;

    struct SymChild
    {
        ULONG       TypeId;
        std::string Type;
        std::string Name;
        ULONG64     Length;
        DWORD64     Offset;

        std::vector<SymChild> children;
    };
} // namespace

namespace debug
{
    enum BasicType // Stolen from CVCONST.H in the DIA 2.0 SDK
    {
        btNoType   = 0,
        btVoid     = 1,
        btChar     = 2,
        btWChar    = 3,
        btInt      = 6,
        btUInt     = 7,
        btFloat    = 8,
        btBCD      = 9,
        btBool     = 10,
        btLong     = 13,
        btULong    = 14,
        btCurrency = 25,
        btDate     = 26,
        btVariant  = 27,
        btComplex  = 28,
        btBit      = 29,
        btBSTR     = 30,
        btHresult  = 31,
    };

    enum DataKind // Stolen from CVCONST.H in the DIA 2.0 SDK
    {
        DataIsUnknown,
        DataIsLocal,
        DataIsStaticLocal,
        DataIsParam,
        DataIsObjectPtr,
        DataIsFileStatic,
        DataIsGlobal,
        DataIsMember,
        DataIsStaticMember,
        DataIsConstant
    };

    char const* const rgBaseType[] = {
        "<user defined>",
        "void",
        "char",
        "wchar_t*",
        "signed char",
        "unsigned char",
        "int",
        "unsigned int",
        "float",
        "<BCD>",
        "bool",
        "short",
        "unsigned short",
        "long",
        "unsigned long",
        "int8",
        "int16",
        "int32",
        "int64",
        "int128",
        "uint8",
        "uint16",
        "uint32",
        "uint64",
        "uint128",
        "<currency>",
        "<date>",
        "VARIANT",
        "<complex>",
        "<bit>",
        "BSTR",
        "HRESULT"
    };

    std::string SystemErrorToString(DWORD errorCode)
    {
        std::string errorString = "UNKNOWN";
        // clang-format off
    switch (errorCode)
    {
        // WinDbg
        case 0x00000000: errorString = "STATUS_WAIT_0"; break;
        case 0x00000080: errorString = "STATUS_ABANDONED_WAIT_0"; break;
        case 0x000000C0: errorString = "STATUS_USER_APC"; break;
        case 0x00000102: errorString = "STATUS_TIMEOUT"; break;
        case 0x00000103: errorString = "STATUS_PENDING"; break;
        case 0x00010001: errorString = "DBG_EXCEPTION_HANDLED"; break;
        case 0x00010002: errorString = "DBG_CONTINUE"; break;
        case 0x40000005: errorString = "STATUS_SEGMENT_NOTIFICATION"; break;
        case 0x40000015: errorString = "STATUS_FATAL_APP_EXIT"; break;
        case 0x40010001: errorString = "DBG_REPLY_LATER"; break;
        case 0x40010003: errorString = "DBG_TERMINATE_THREAD"; break;
        case 0x40010004: errorString = "DBG_TERMINATE_PROCESS"; break;
        case 0x40010005: errorString = "DBG_CONTROL_C"; break;
        case 0x40010006: errorString = "DBG_PRINTEXCEPTION_C"; break;
        case 0x40010007: errorString = "DBG_RIPEXCEPTION"; break;
        case 0x40010008: errorString = "DBG_CONTROL_BREAK"; break;
        case 0x40010009: errorString = "DBG_COMMAND_EXCEPTION"; break;
        case 0x4001000A: errorString = "DBG_PRINTEXCEPTION_WIDE_C"; break;
        case 0x80000001: errorString = "STATUS_GUARD_PAGE_VIOLATION"; break;
        case 0x80000002: errorString = "STATUS_DATATYPE_MISALIGNMENT"; break;
        case 0x80000003: errorString = "STATUS_BREAKPOINT"; break;
        case 0x80000004: errorString = "STATUS_SINGLE_STEP"; break;
        case 0x80000026: errorString = "STATUS_LONGJUMP"; break;
        case 0x80000029: errorString = "STATUS_UNWIND_CONSOLIDATE"; break;
        case 0x80010001: errorString = "DBG_EXCEPTION_NOT_HANDLED"; break;
        case 0xC0000005: errorString = "STATUS_ACCESS_VIOLATION"; break;
        case 0xC0000006: errorString = "STATUS_IN_PAGE_ERROR"; break;
        case 0xC0000008: errorString = "STATUS_INVALID_HANDLE"; break;
        case 0xC000000D: errorString = "STATUS_INVALID_PARAMETER"; break;
        case 0xC0000017: errorString = "STATUS_NO_MEMORY"; break;
        case 0xC000001D: errorString = "STATUS_ILLEGAL_INSTRUCTION"; break;
        case 0xC0000025: errorString = "STATUS_NONCONTINUABLE_EXCEPTION"; break;
        case 0xC0000026: errorString = "STATUS_INVALID_DISPOSITION"; break;
        case 0xC000008C: errorString = "STATUS_ARRAY_BOUNDS_EXCEEDED"; break;
        case 0xC000008D: errorString = "STATUS_FLOAT_DENORMAL_OPERAND"; break;
        case 0xC000008E: errorString = "STATUS_FLOAT_DIVIDE_BY_ZERO"; break;
        case 0xC000008F: errorString = "STATUS_FLOAT_INEXACT_RESULT"; break;
        case 0xC0000090: errorString = "STATUS_FLOAT_INVALID_OPERATION"; break;
        case 0xC0000091: errorString = "STATUS_FLOAT_OVERFLOW"; break;
        case 0xC0000092: errorString = "STATUS_FLOAT_STACK_CHECK"; break;
        case 0xC0000093: errorString = "STATUS_FLOAT_UNDERFLOW"; break;
        case 0xC0000094: errorString = "STATUS_INTEGER_DIVIDE_BY_ZERO"; break;
        case 0xC0000095: errorString = "STATUS_INTEGER_OVERFLOW"; break;
        case 0xC0000096: errorString = "STATUS_PRIVILEGED_INSTRUCTION"; break;
        case 0xC00000FD: errorString = "STATUS_STACK_OVERFLOW"; break;
        case 0xC0000135: errorString = "STATUS_DLL_NOT_FOUND"; break;
        case 0xC0000138: errorString = "STATUS_ORDINAL_NOT_FOUND"; break;
        case 0xC0000139: errorString = "STATUS_ENTRYPOINT_NOT_FOUND"; break;
        case 0xC000013A: errorString = "STATUS_CONTROL_C_EXIT"; break;
        case 0xC0000142: errorString = "STATUS_DLL_INIT_FAILED"; break;
        case 0xC00001B2: errorString = "STATUS_CONTROL_STACK_VIOLATION"; break;
        case 0xC00002B4: errorString = "STATUS_FLOAT_MULTIPLE_FAULTS"; break;
        case 0xC00002B5: errorString = "STATUS_FLOAT_MULTIPLE_TRAPS"; break;
        case 0xC00002C9: errorString = "STATUS_REG_NAT_CONSUMPTION"; break;
        case 0xC0000374: errorString = "STATUS_HEAP_CORRUPTION"; break;
        case 0xC0000409: errorString = "STATUS_STACK_BUFFER_OVERRUN"; break;
        case 0xC0000417: errorString = "STATUS_INVALID_CRUNTIME_PARAMETER"; break;
        case 0xC0000420: errorString = "STATUS_ASSERTION_FAILURE"; break;
        case 0xC00004A2: errorString = "STATUS_ENCLAVE_VIOLATION"; break;
        case 0xC0000515: errorString = "STATUS_INTERRUPTED"; break;
        case 0xC0000516: errorString = "STATUS_THREAD_NOT_RUNNING"; break;
        case 0xC0000718: errorString = "STATUS_ALREADY_REGISTERED"; break;
        case 0xC015000F: errorString = "STATUS_SXS_EARLY_DEACTIVATION"; break;
        case 0xC0150010: errorString = "STATUS_SXS_INVALID_DEACTIVATION"; break;
    }
        // clang-format on

        return fmt::format("{} ({:#08X})", errorString, errorCode);
    }

    std::string getExeFilename()
    {
        char buf[MAX_PATH];
        GetModuleFileNameA(nullptr, buf, MAX_PATH);
        return PathFindFileNameA(buf);
    }

    std::string StrFromWchar(wchar_t const* const wString)
    {
        size_t const      len    = wcslen(wString) + 1;
        size_t const      nBytes = len * sizeof(wchar_t);
        std::vector<char> chArray(nBytes);
        wcstombs(&chArray[0], wString, nBytes);
        return std::string(&chArray[0]);
    }

    BasicType GetBasicType(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex)
    {
        BasicType basicType;
        if (SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_BASETYPE, &basicType))
        {
            return basicType;
        }

        // Get the real "TypeId" of the child.  We need this for the
        // SymGetTypeInfo(TI_GET_TYPEID) call below.
        DWORD typeId;
        if (SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_TYPEID, &typeId))
        {
            if (SymGetTypeInfo(Process, ModBase, typeId, TI_GET_BASETYPE, &basicType))
            {
                return basicType;
            }
        }

        return btNoType;
    }

    std::string GetSymName(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex)
    {
        WCHAR* WName = L"";
        if (!SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_SYMNAME, &WName))
        {
            return "";
        }
        std::string Name = StrFromWchar(WName);
        LocalFree(WName);

        // Simplify types for display

        if (Name == "std::basic_string<char,std::char_traits<char>,std::allocator<char> >")
        {
            Name = "std::string";
        }

        std::string LowerName = Name;
        std::transform(Name.begin(), Name.end(), LowerName.begin(),
                       [](unsigned char c)
                       { return std::tolower(c); });

        if (LowerName.find("iterator") != std::string::npos)
        {
            Name = "iterator";
        }

        if (LowerName.find("time_point") != std::string::npos)
        {
            Name = "time_point";
        }

        return Name;
    }

    ULONG64 GetSymLength(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex)
    {
        ULONG64 Length = 0;
        if (!SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_LENGTH, &Length))
        {
            return 0;
        }
        return Length;
    }

    bool CheckTag(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex, ULONG Tag)
    {
        DWORD SymTag = SymTagNull;
        if (!SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_SYMTAG, &SymTag))
        {
            return false;
        }

        return SymTag == Tag;
    }

    // Forward declare
    bool DumpType(HANDLE Process, DWORD64 ModBase, DWORD TypeIndex, std::string& TypeName);

    bool DumpBaseType(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex, std::string& TypeName)
    {
        if (!CheckTag(Process, ModBase, TypeIndex, SymTagBaseType))
        {
            return false;
        }

        BasicType basicType = GetBasicType(Process, ModBase, TypeIndex);
        TypeName += rgBaseType[basicType];

        return true;
    }

    bool DumpPointerType(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex, std::string& TypeName)
    {
        if (!CheckTag(Process, ModBase, TypeIndex, SymTagPointerType))
        {
            return false;
        }

        // Pointed to type
        ULONG TargetTypeIndex;
        if (!SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_TYPEID, &TargetTypeIndex))
        {
            return false;
        }

        ULONG64 Length = 0;
        if (!SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_LENGTH, &Length))
        {
            return false;
        }

        BOOL IsReference;
        SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_IS_REFERENCE, &IsReference);

        TypeName += (IsReference) ? "&" : "*";

        DumpType(Process, ModBase, TargetTypeIndex, TypeName);

        return true;
    }

    bool DumpTypedef(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex, std::string& TypeName)
    {
        if (!CheckTag(Process, ModBase, TypeIndex, SymTagTypedef))
        {
            return false;
        }

        std::string Name = GetSymName(Process, ModBase, TypeIndex);

        TypeName += Name;

        return true;
    }

    bool DumpEnum(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex, std::string& TypeName)
    {
        if (!CheckTag(Process, ModBase, TypeIndex, SymTagEnum))
        {
            return false;
        }

        std::string Name = GetSymName(Process, ModBase, TypeIndex);

        TypeName += Name;

        return true;
    }

    bool DumpArrayType(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex, std::string& TypeName)
    {
        if (!CheckTag(Process, ModBase, TypeIndex, SymTagArrayType))
        {
            return false;
        }

        // TODO: Get array type

        ULONG64 Length = GetSymLength(Process, ModBase, TypeIndex);

        TypeName += fmt::format("[{}]", Length);

        return true;
    }

    std::vector<SymChild> gChildren;

    std::vector<ULONG> GetChildIds(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex)
    {
        DWORD NumChildren = 0;
        if (!SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_CHILDRENCOUNT, &NumChildren))
        {
            return {};
        }

        if (NumChildren == 0)
        {
            return {};
        }

        // Get the children
        int                     FindChildrenSize = sizeof(TI_FINDCHILDREN_PARAMS) + NumChildren * sizeof(ULONG);
        TI_FINDCHILDREN_PARAMS* pFC              = (TI_FINDCHILDREN_PARAMS*)_alloca(FindChildrenSize);
        memset(pFC, 0, FindChildrenSize);

        pFC->Count = NumChildren;
        if (!SymGetTypeInfo(Process, ModBase, TypeIndex, TI_FINDCHILDREN, pFC))
        {
            return {};
        }

        std::vector<ULONG> outVec;
        for (DWORD i = pFC->Start; i < pFC->Count; i++)
        {
            ULONG ChildId = pFC->ChildId[i];
            outVec.emplace_back(ChildId);
        }

        return outVec;
    }

    SymChild BuildSymChild(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex)
    {
        std::string VarType = "";
        DumpType(Process, ModBase, TypeIndex, VarType);

        // Target type of the Child
        ULONG TargetTypeId;
        if (!SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_TYPEID, &TargetTypeId))
        {
            return {};
        }

        // Length of the Child type
        ULONG64 Length;
        if (!SymGetTypeInfo(Process, ModBase, TargetTypeId, TI_GET_LENGTH, &Length))
        {
            return {};
        }

        // Child offset from the parent's address
        DWORD ChildOffset;
        if (!SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_OFFSET, &ChildOffset))
        {
            return {};
        }

        SymChild child;
        child.Type   = VarType;
        child.TypeId = TargetTypeId;
        child.Name   = GetSymName(Process, ModBase, TypeIndex);
        child.Length = Length;
        child.Offset = ChildOffset;

        auto ChildIds = GetChildIds(Process, ModBase, TypeIndex);
        for (auto ChildId : ChildIds)
        {
            // Variables
            //if (CheckTag(Process, ModBase, ChildId, SymTagData))
            {
                child.children.emplace_back(BuildSymChild(Process, ModBase, ChildId));
            }
        }

        return child;
    }

    bool DumpUDT(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex, std::string& TypeName)
    {
        if (!CheckTag(Process, ModBase, TypeIndex, SymTagUDT))
        {
            return false;
        }

        std::string Name = GetSymName(Process, ModBase, TypeIndex);

        TypeName += Name;

        auto ChildIds = GetChildIds(Process, ModBase, TypeIndex);
        for (auto ChildId : ChildIds)
        {
            // Base Classes
            if (CheckTag(Process, ModBase, ChildId, SymTagBaseClass))
            {
                std::string ChildName = GetSymName(Process, ModBase, ChildId);
                TypeName += "<";
                DumpType(Process, ModBase, ChildId, TypeName);
                TypeName += ">";
            }

            // Variables
            if (CheckTag(Process, ModBase, ChildId, SymTagData))
            {
                // TODO: A better way to filter the tree
                std::string VarName = GetSymName(Process, ModBase, ChildId);
                if (VarName == "id" || VarName == "name" || VarName == "loc" ||
                    VarName == "zone" || VarName == "m_zoneID" || VarName == "p")
                {
                    gChildren.emplace_back(BuildSymChild(Process, ModBase, ChildId));
                }
            }

            // Functions
            if (CheckTag(Process, ModBase, ChildId, SymTagFunction))
            {
                // Intentionally blank
            }
        }

        return true;
    }

    bool DumpFunction(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex, std::string& TypeName)
    {
        if (!CheckTag(Process, ModBase, TypeIndex, SymTagFunction))
        {
            return false;
        }

        ULONG TargetTypeIndex;
        if (!SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_TYPEID, &TargetTypeIndex))
        {
            return false;
        }

        DumpType(Process, ModBase, TargetTypeIndex, TypeName);

        return true;
    }

    bool DumpBaseClass(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex, std::string& TypeName)
    {
        if (!CheckTag(Process, ModBase, TypeIndex, SymTagBaseClass))
        {
            return false;
        }

        ULONG TargetTypeIndex;
        if (!SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_TYPEID, &TargetTypeIndex))
        {
            return false;
        }

        DumpType(Process, ModBase, TargetTypeIndex, TypeName);

        return true;
    }

    bool DumpData(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex, std::string& TypeName)
    {
        if (!CheckTag(Process, ModBase, TypeIndex, SymTagData))
        {
            return false;
        }

        ULONG TargetTypeIndex;
        if (!SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_TYPEID, &TargetTypeIndex))
        {
            return false;
        }

        DumpType(Process, ModBase, TargetTypeIndex, TypeName);

        return true;
    }

    bool DumpType(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex, std::string& TypeName)
    {
        DWORD Tag = SymTagNull;
        if (!SymGetTypeInfo(Process, ModBase, TypeIndex, TI_GET_SYMTAG, &Tag))
        {
            return false;
        }

        switch (Tag)
        {
            case SymTagBaseType:
                DumpBaseType(Process, ModBase, TypeIndex, TypeName);
                break;
            case SymTagPointerType:
                DumpPointerType(Process, ModBase, TypeIndex, TypeName);
                break;
            case SymTagTypedef:
                DumpTypedef(Process, ModBase, TypeIndex, TypeName);
                break;
            case SymTagEnum:
                DumpEnum(Process, ModBase, TypeIndex, TypeName);
                break;
            case SymTagArrayType:
                DumpArrayType(Process, ModBase, TypeIndex, TypeName);
                break;
            case SymTagUDT:
                DumpUDT(Process, ModBase, TypeIndex, TypeName);
                break;
            case SymTagFunction:
                DumpFunction(Process, ModBase, TypeIndex, TypeName);
                break;
            case SymTagBaseClass:
                DumpBaseClass(Process, ModBase, TypeIndex, TypeName);
                break;
            case SymTagData:
                DumpData(Process, ModBase, TypeIndex, TypeName);
                break;
            default:
                // Do not handle
                break;
        }

        return true;
    }

    std::string GetTypeValue(HANDLE Process, DWORD64 ModBase, ULONG TypeIndex, DWORD_PTR Address, ULONG64 Length)
    {
        std::string ValueStr = "?";

        try
        {
            BasicType basicType = GetBasicType(Process, ModBase, TypeIndex);
            if (basicType == BasicType::btBool || basicType == BasicType::btUInt)
            {
                switch (Length)
                {
                    case 1:
                        ValueStr = fmt::format("{}", *(BYTE*)Address);
                        break;
                    case 2:
                        ValueStr = fmt::format("{}", *(WORD*)Address);
                        break;
                    case 4:
                        ValueStr = fmt::format("{0} (0x{0:X})", *(DWORD*)Address);
                        break;
                    case 8:
                        ValueStr = fmt::format("{0} (0x{0:I64X})", *(DWORD64*)Address);
                        break;
                }
            }

            if (basicType == BasicType::btInt)
            {
                switch (Length)
                {
                    case 1:
                        ValueStr = fmt::format("{}", *(char*)Address);
                        break;
                    case 2:
                        ValueStr = fmt::format("{}", *(short*)Address);
                        break;
                    case 4:
                        ValueStr = fmt::format("{0} (0x{0:X})", *(long*)Address);
                        break;
                    case 8:
                        ValueStr = fmt::format("{0} (0x{0:I64X})", *(long long*)Address);
                        break;
                }
            }

            //if (basicType == BasicType::btChar)
            //{
            //    ValueStr = std::string((char*)Address, std::strlen((char*)Address));
            //}

            //std::string TypeName = GetSymName(Process, ModBase, TypeIndex);
            //if (TypeName == "std::string")
            //{
            //    ValueStr = *(std::string*)Address;
            //}
        }
        catch (std::exception& e)
        {
            ValueStr = fmt::format("<deref failed> ({})", e.what());
        }

        return ValueStr;
    }

    void OutputChildren(HANDLE Process, DWORD64 ModBase, DWORD_PTR Address, std::vector<SymChild>& vec, int depth = 0)
    {
        for (auto& child : vec)
        {
            std::string childValueStr = GetTypeValue(Process, ModBase, child.TypeId, Address - child.Offset, child.Length);
            auto        childStr      = fmt::format("{} {}({}): {}", child.Type, child.Name, child.Length, childValueStr);

            std::string padding = "";
            for (int i = 0; i < depth; ++i)
            {
                padding += "    ";
            }
            ShowStacktrace("        %sV %s", padding, childStr);

            OutputChildren(Process, ModBase, Address - child.Offset, child.children, depth + 1);
        }
    }

    BOOL CALLBACK EnumSymProc(
        PSYMBOL_INFO pSymInfo,
        ULONG        SymbolSize,
        PVOID        UserContext)
    {
        if (pSymInfo->Tag == SymTagFunction)
        {
            return FALSE;
        }

        // Clear global tracking of sym children
        gChildren = {};

        HANDLE        Process     = GetCurrentProcess();
        STACKFRAME64* pStackFrame = (STACKFRAME64*)UserContext;

        DWORD_PTR Address = pSymInfo->Address; // Will point to the variable's data in memory
        DWORD64   Offset;
        if (pSymInfo->Flags & IMAGEHLP_SYMBOL_INFO_REGRELATIVE)
        {
#ifdef _M_IX86
            Offset = pStackFrame->AddrFrame.Offset;
#elif _M_X64
            Offset = pStackFrame->AddrStack.Offset;
#endif
            Address += Offset;
        }

        // NOTE: pSymInfo->Value doesn't contain anything
        std::string TypeName = "";
        DumpType(Process, pSymInfo->ModBase, pSymInfo->TypeIndex, TypeName);

        std::string Prefix = "";
        if (pSymInfo->Flags & IMAGEHLP_SYMBOL_INFO_PARAMETER)
        {
            Prefix = "P";
        }
        else if (pSymInfo->Flags & IMAGEHLP_SYMBOL_INFO_LOCAL)
        {
            Prefix = "L";
        }

        ULONG64 Length = GetSymLength(Process, pSymInfo->ModBase, pSymInfo->TypeIndex);

        std::string ValueStr = GetTypeValue(Process, pSymInfo->ModBase, pSymInfo->TypeIndex, Address, Length);

        ShowStacktrace("    %s %s(%u) %s: %s", Prefix, TypeName, Length, pSymInfo->Name, ValueStr);

        // TODO: Complete data gathering for values so they can be outputted properly
        //OutputChildren(Process, pSymInfo->ModBase, Address, gChildren);

        return TRUE;
    }

    PVOID gExceptionHandlerHandle;

    std::size_t number_of_files_in_directory(std::filesystem::path path)
    {
        using std::filesystem::directory_iterator;
        return std::distance(directory_iterator(path), directory_iterator{});
    }

    // https://stackoverflow.com/a/50208684
    // From MSDN.WhiteKnight
    LONG WINAPI TopLevelExceptionHandler(PEXCEPTION_POINTERS pExceptionInfo)
    {
        // https://www.freelists.org/post/luajit/FirstChance-Exception-in-luajit,1
        // https://love2d.org/forums/viewtopic.php?t=84336
        switch (pExceptionInfo->ExceptionRecord->ExceptionCode)
        {
                // LuaJIT throws and handles exceptions as part of its regular runtime.
                // We should ignore these. By using Sol, there is no scenario where we want a Lua error to be fatal.
                // The LuaJIT exception codes are all built by OR-ing 0xE24C4A00 with the relevant Lua error codes:
                // https://github.com/LuaJIT/LuaJIT/blob/4deb5a1588ed53c0c578a343519b5ede59f3d928/src/lj_err.c#L250-L256
                // https://github.com/LuaJIT/LuaJIT/blob/20f556e53190ab9a735b932f5d868d45ec536a70/src/lua.h#L42-L48
            case 0xE24C4A00: // LUA_OK (0)
                [[fallthrough]];
            case 0xE24C4A01: // LUA_YIELD (1)
                [[fallthrough]];
            case 0xE24C4A02: // LUA_ERRRUN (2)
                [[fallthrough]];
            case 0xE24C4A03: // LUA_ERRSYNTAX (3)
                [[fallthrough]];
            case 0xE24C4A04: // LUA_ERRMEM (4)
                [[fallthrough]];
            case 0xE24C4A05: // LUA_ERRERR (5)
                return EXCEPTION_CONTINUE_SEARCH;

            // Exceptions thrown internally (like is possible in AI state transitions) should also be ignored
            case 0xE06D7363: // Internal application exception code
                return EXCEPTION_CONTINUE_SEARCH;

            default:
                break;
        }

        // At this point, we aren't going to recover.
        // Disconnect this handler in case our handling code fails - creating a deathloop
        RemoveVectoredExceptionHandler(gExceptionHandlerHandle);

        // It appears as though removing the handle doesn't take effect immediately.
        // As a safety precaution, we will track the "depth" of how many times we've
        // used this handler.
        // If we go deeper than 0, we're in a loop, so abort!
        if (CrashDepth > 0)
        {
            ShowStacktrace("================================================================");
            ShowStacktrace("!!! INTERNAL CRASH !!!");
            ShowStacktrace("Exception %s occured!", SystemErrorToString(pExceptionInfo->ExceptionRecord->ExceptionCode));
            ShowStacktrace("The internal erorr handler has crashed, please report this to upstream!");
            ShowStacktrace("================================================================");
            TerminateProcess(GetCurrentProcess(), 1);
        }
        ++CrashDepth;

        auto        exeName = getExeFilename();
        std::time_t t       = std::time(nullptr);
        auto        timeStr = fmt::format("{:%Y_%m_%d_%H_%M_%S}", fmt::localtime(t));

        // Create dmp folder (if needed)
        if (!std::filesystem::is_directory("dmp") || !std::filesystem::exists("dmp"))
        {
            std::filesystem::create_directory("dmp"); // create src folder
        }

        auto tooManyDumps = number_of_files_in_directory("dmp") >= 3;

        // Create dump
        // https://docs.microsoft.com/en-gb/windows/win32/dxtecharts/crash-dump-analysis
        bool dumpEnabled = true; // TODO: Make me a setting
        if (dumpEnabled && !tooManyDumps)
        {
            auto dumpName = fmt::format(".\\dmp\\{}_{}.dmp", getExeFilename(), timeStr);

            BOOL                           bMiniDumpSuccessful;
            HANDLE                         hDumpFile;
            MINIDUMP_EXCEPTION_INFORMATION ExpParam;

            hDumpFile = CreateFileA(dumpName.c_str(), GENERIC_READ | GENERIC_WRITE,
                                    FILE_SHARE_WRITE | FILE_SHARE_READ, 0, CREATE_ALWAYS, 0, 0);

            ExpParam.ThreadId          = GetCurrentThreadId();
            ExpParam.ExceptionPointers = pExceptionInfo;
            ExpParam.ClientPointers    = TRUE;

            bMiniDumpSuccessful = MiniDumpWriteDump(GetCurrentProcess(), GetCurrentProcessId(),
                                                    hDumpFile, (_MINIDUMP_TYPE)(MiniDumpWithDataSegs | MiniDumpWithFullMemory), &ExpParam, NULL, NULL);

            CloseHandle(hDumpFile);
        }

        // Create stacktrace

        HANDLE process = GetCurrentProcess();
        HANDLE thread  = GetCurrentThread();

        // A fatal event has occured, from this point on all code executed comes from our error handling.
        // We no longer need to trace where each log comes from, so change to a cleaner pattern.
        spdlog::set_pattern("[%D %T:%e]%^[%l][%n]%$ %v");

        ShowStacktrace("================================================================");
        ShowStacktrace("!!! CRASH !!!");
        ShowStacktrace("Exception %s occured!", SystemErrorToString(pExceptionInfo->ExceptionRecord->ExceptionCode));
        if (dumpEnabled)
        {
            if (!tooManyDumps)
            {
                ShowStacktrace("A crash dump has been created: <repo root>/dmp/%s_%s.dmp", getExeFilename(), timeStr);
            }
            else
            {
                ShowStacktrace("There are too many dumps in your /dmp/ folder, you should clean it out. Skipping memory dump!");
            }
        }
        ShowStacktrace("================================================================");

        // Process information
        ShowStacktrace("Process Name: %s", exeName);

        auto uptimeDuration = server_clock::now() - StartUpTime;
        if (uptimeDuration < std::chrono::minutes(2))
        {
            ShowStacktrace("Process Uptime: %s", fmt::format("{} seconds", std::chrono::duration_cast<std::chrono::seconds>(uptimeDuration).count()));
        }
        else if (uptimeDuration > std::chrono::minutes(120))
        {
            ShowStacktrace("Process Uptime: %s", fmt::format("{} hours", std::chrono::duration_cast<std::chrono::hours>(uptimeDuration).count()));
        }
        else
        {
            ShowStacktrace("Process Uptime: %s", fmt::format("{} minutes", std::chrono::duration_cast<std::chrono::minutes>(uptimeDuration).count()));
        }

        PROCESS_MEMORY_COUNTERS PMC;
        ULONGLONG               TotalMemoryInKilobytes;
        if (GetProcessMemoryInfo(process, &PMC, sizeof(PMC)) && GetPhysicallyInstalledSystemMemory(&TotalMemoryInKilobytes))
        {
            ShowStacktrace("Process Memory Usage %uMiB / %uMiB", PMC.WorkingSetSize / 1024 / 1024, TotalMemoryInKilobytes / 1024);
        }

        // Git information
        ShowStacktrace("Git SHA: %s", version::GetGitSha());
        ShowStacktrace("Git Date: %s", version::GetGitDate());
        ShowStacktrace("Git Branch: %s", version::GetGitBranch());
        ShowStacktrace("Git Subject: %s", version::GetGitCommitSubject());

        ShowStacktrace("================================================================");

        CONTEXT* ctx = pExceptionInfo->ContextRecord;

        BOOL    result;
        HMODULE hModule;

        STACKFRAME64 stack;
        ULONG        frame;
        DWORD64      displacement;

        DWORD            disp;
        IMAGEHLP_LINE64* line;

        char         buffer[sizeof(SYMBOL_INFO) + MAX_SYM_NAME * sizeof(TCHAR)];
        char         name[256];
        char         module[256];
        PSYMBOL_INFO pSymbol = (PSYMBOL_INFO)buffer;

        memset(&stack, 0, sizeof(STACKFRAME64));

        displacement = 0;
#if !defined(_M_AMD64)
        stack.AddrPC.Offset    = (*ctx).Eip;
        stack.AddrPC.Mode      = AddrModeFlat;
        stack.AddrStack.Offset = (*ctx).Esp;
        stack.AddrStack.Mode   = AddrModeFlat;
        stack.AddrFrame.Offset = (*ctx).Ebp;
        stack.AddrFrame.Mode   = AddrModeFlat;
#endif

        SymInitialize(process, NULL, TRUE); // load symbols

        for (frame = 0;; frame++)
        {
            // get next call from stack
            result = StackWalk64(
#if defined(_M_AMD64)
                IMAGE_FILE_MACHINE_AMD64
#else
                IMAGE_FILE_MACHINE_I386
#endif
                ,
                process,
                thread,
                &stack,
                ctx,
                NULL,
                SymFunctionTableAccess64,
                SymGetModuleBase64,
                NULL);

            if (!result)
            {
                break;
            }

            // get symbol name for address
            pSymbol->SizeOfStruct = sizeof(SYMBOL_INFO);
            pSymbol->MaxNameLen   = MAX_SYM_NAME;
            SymFromAddr(process, (ULONG64)stack.AddrPC.Offset, &displacement, pSymbol);

            line               = (IMAGEHLP_LINE64*)malloc(sizeof(IMAGEHLP_LINE64));
            line->SizeOfStruct = sizeof(IMAGEHLP_LINE64);

            // try to get line
            if (SymGetLineFromAddr64(process, stack.AddrPC.Offset, &disp, line))
            {
                ShowStacktrace("at %s in %s: line: %lu: address: 0x%0X", pSymbol->Name, line->FileName, line->LineNumber, pSymbol->Address);
            }
            else
            {
                // failed to get line
                ShowStacktrace("at %s, address 0x%0X.", pSymbol->Name, pSymbol->Address);
                hModule = NULL;
                lstrcpyA(module, "");
                GetModuleHandleEx(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
                                  (LPCTSTR)(stack.AddrPC.Offset), &hModule);

                // at least print module name
                if (hModule != NULL)
                {
                    GetModuleFileNameA(hModule, module, 256);
                }

                ShowStacktrace("in %s", module);
            }

            free(line);
            line = NULL;

            // Print locals to frame
            IMAGEHLP_STACK_FRAME sf;
            sf.InstructionOffset = stack.AddrPC.Offset;
            SymSetContext(process, &sf, NULL);

            // TODO: This is a bit error prone, FIXME
            //char* Mask = "*";
            //SymEnumSymbols(process, 0, Mask, EnumSymProc, &stack);

            // No need to dig deeper than main
            if (std::strcmp(pSymbol->Name, "main") == 0)
            {
                break;
            }
        }

        ShowStacktrace("================================================================");

        SymCleanup(process);

        // No need to continue searching for more exception handlers, terminate process now.
        TerminateProcess(process, 1);

        return EXCEPTION_CONTINUE_SEARCH;
    }

    void init()
    {
        // Get rid of the "Debug Assertion Failed" popup, so that
        // our own error handling code can run uninterrupted.
        _CrtSetReportMode(_CRT_WARN, _CRTDBG_MODE_DEBUG);
        _CrtSetReportMode(_CRT_ERROR, _CRTDBG_MODE_DEBUG);
        _CrtSetReportMode(_CRT_ASSERT, _CRTDBG_MODE_DEBUG);

        gExceptionHandlerHandle = AddVectoredExceptionHandler(1, TopLevelExceptionHandler);
    }
} // namespace debug
