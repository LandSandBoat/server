-----------------------------------
--  Area/Content Identifiers
-----------------------------------
require('scripts/globals/utils')
-----------------------------------

-- NOTE: This should only be used to support GM commands, and is deprecated
-- by explicitly defining fame area, mission, and quest log IDs from their
-- respective tables.

local logIdHelpers = {}

local qmLogInfo =
{
    SANDORIA =
    {
        ['full_name']   = "San d'Oria",
        ['mission_log'] = 0,
        ['quest_log']   = 0,
        ['fame_area']   = 0,
    },

    BASTOK =
    {
        ['full_name']   = "Bastok",
        ['mission_log'] = 1,
        ['quest_log']   = 1,
        ['fame_area']   = 1,
    },

    WINDURST =
    {
        ['full_name']   = "Windurst",
        ['mission_log'] = 2,
        ['quest_log']   = 2,
        ['fame_area']   = 2,
    },

    JEUNO =
    {
        ['full_name'] = "Jeuno",
        ['quest_log'] = 3,
        ['fame_area'] = 3,
    },

    SELBINA =
    {
        ['full_name'] = "Selbina",
        ['quest_log'] = 4,
        ['fame_area'] = 4,
    },

    MHAURA =
    {
        ['full_name'] = "Mhaura",
        ['quest_log'] = 4,
        ['fame_area'] = 2,
    },

    RABAO =
    {
        ['full_name'] = "Rabao",
        ['quest_log'] = 5,
        ['fame_area'] = 4,
    },

    KAZHAM =
    {
        ['full_name'] = "Kazham",
        ['quest_log'] = 5,
        ['fame_area'] = 2,
    },

    NORG =
    {
        ['full_name'] = "Norg",
        ['quest_log'] = 5,
        ['fame_area'] = 5,
    },

    OTHER_AREAS_LOG =
    {
        ['full_name'] = "Other Areas",
        ['quest_log'] = 4,
    },

    TAVNAZIA =
    {
        ['full_name'] = "Tavnazian Safehold",
        ['quest_log'] = 4,
    },

    OUTLANDS =
    {
        ['full_name'] = "Outlands",
        ['quest_log'] = 5,
    },

    ZILART =
    {
        ['full_name']   = "Rise of the Zilart",
        ['mission_log'] = 3,
        ['quest_log']   = 5,
    },

    COP =
    {
        ['full_name']   = "Chains of Promathia",
        ['mission_log'] = 6,
        ['quest_log']   = 4,
    },

    TOAU =
    {
        ['full_name']   = "Treasures of Aht Urhgan",
        ['mission_log'] = 4,
        ['quest_log']   = 6,
    },

    AHT_URHGAN =
    {
        ['full_name']   = "Aht Urhgan",
        ['mission_log'] = 4,
        ['quest_log']   = 6,
    },

    ASSAULT =
    {
        ['full_name']   = "Assault",
        ['mission_log'] = 7,
    },

    WOTG =
    {
        ['full_name']   = "Wings of the Goddess",
        ['mission_log'] = 5,
        ['quest_log']   = 7,
    },

    CRYSTAL_WAR =
    {
        ['full_name']   = "Crystal War",
        ['mission_log'] = 5,
        ['quest_log']   = 7,
    },

    CAMPAIGN =
    {
        ['full_name']   = "Campaign",
        ['mission_log'] = 8,
    },

    ACP =
    {
        ['full_name']   = "A Crystalline Prophecy",
        ['mission_log'] = 9,
    },

    AMK =
    {
        ['full_name']   = "A Moogle Kupo d'Etat",
        ['mission_log'] = 10,
    },

    ASA =
    {
        ['full_name']   = "A Shantotto Ascension",
        ['mission_log'] = 11,
    },

    ABYSSEA =
    {
        ['full_name'] = "Abyssea",
        ['quest_log'] = 8,
    },

    ABYSSEA_KONSCHTAT =
    {
        ['full_name'] = "Abyssea - Konschtat",
        ['quest_log'] = 8,
        ['fame_area'] = 6,
    },

    ABYSSEA_TAHRONGI =
    {
        ['full_name'] = "Abyssea - Tahrongi",
        ['quest_log'] = 8,
        ['fame_area'] = 7,
    },

    ABYSSEA_LATHEINE =
    {
        ['full_name'] = "Abyssea - La'Theine",
        ['quest_log'] = 8,
        ['fame_area'] = 8,
    },

    ABYSSEA_MISAREAUX =
    {
        ['full_name'] = "Abyssea - Misareaux",
        ['quest_log'] = 8,
        ['fame_area'] = 9,
    },

    ABYSSEA_VUNKERL =
    {
        ['full_name'] = "Abyssea - Vunkerl",
        ['quest_log'] = 8,
        ['fame_area'] = 10,
    },

    ABYSSEA_ATTOHWA =
    {
        ['full_name'] = "Abyssea - Attohwa",
        ['quest_log'] = 8,
        ['fame_area'] = 11,
    },

    ABYSSEA_ALTEPA =
    {
        ['full_name'] = "Abyssea - Altepa",
        ['quest_log'] = 8,
        ['fame_area'] = 12,
    },

    ABYSSEA_GRAUBERG =
    {
        ['full_name'] = "Abyssea - Grauberg",
        ['quest_log'] = 8,
        ['fame_area'] = 13,
    },

    ABYSSEA_ULEGUERAND =
    {
        ['full_name'] = "Abyssea - Uleguerand",
        ['quest_log'] = 8,
        ['fame_area'] = 14,
    },

    SOA =
    {
        ['full_name']   = "Seekers of Adoulin",
        ['mission_log'] = 12,
        ['quest_log']   = 9,
        ['fame_area']   = 15,
    },

    ADOULIN =
    {
        ['full_name']   = "Adoulin",
        ['mission_log'] = 12,
        ['quest_log']   = 9,
        ['fame_area']   = 15,
    },

    COALITION =
    {
        ['full_name'] = "Coalition",
        ['quest_log'] = 10,
    },

    ROV =
    {
        ['full_name']   = "Rhapsodies of Vana'diel",
        ['mission_log'] = 13,
    },
}

local questLogs =
{
    [0] = "SANDORIA",
    [1] = "BASTOK",
    [2] = "WINDURST",
    [3] = "JEUNO",
    [4] = "OTHER_AREAS_LOG",
    [5] = "OUTLANDS",
    [6] = "TOAU",
    [7] = "WOTG",
    [8] = "ABYSSEA",
    [9] = "SOA",
    [10] = "COALITION",
}

local missionLogs =
{
    [0] = "SANDORIA",
    [1] = "BASTOK",
    [2] = "WINDURST",
    [3] = "ZILART",
    [4] = "TOAU",
    [5] = "WOTG",
    [6] = "COP",
    [7] = "ASSAULT",
    [8] = "CAMPAIGN",
    [9] = "ACP",
    [10] = "AMK",
    [11] = "ASA",
    [12] = "SOA",
    [13] = "ROV",
}

local function getQMLogInfo(cmdParamText, logNameTable)
    -- Returns the table from this file after validating
    if cmdParamText == nil then
        return nil
    end

    if type(logNameTable) ~= "table" then
        return nil
    end

    local logName
    local ret = nil
    local logIdNum = tonumber(cmdParamText)

    if logIdNum ~= nil then
        logName = logNameTable[logIdNum]
    else
        logName = string.upper(cmdParamText)
    end

    if logName ~= nil then
        ret = qmLogInfo[logName]

        if
            type(ret) == "table" and
            type(ret.full_name) == "string"
        then
            return ret
        else
            logName = logName .. "_LOG"
            ret = qmLogInfo[logName]

            if
                type(ret) == "table" and
                type(ret.full_name) == "string"
            then
                return ret
            end
        end
    end

    return nil
end

logIdHelpers.getQuestLogInfo = function(cmdParamText)
    local ret = getQMLogInfo(cmdParamText, questLogs)

    if
        type(ret) == "table" and
        type(ret.quest_log) == "number"
    then
        return ret
    else
        return nil
    end
end

logIdHelpers.getMissionLogInfo = function(cmdParamText)
    local ret = getQMLogInfo(cmdParamText, missionLogs)

    if
        type(ret) == "table" and
        type(ret.mission_log) == "number"
    then
        return ret
    else
        return nil
    end
end

return logIdHelpers
