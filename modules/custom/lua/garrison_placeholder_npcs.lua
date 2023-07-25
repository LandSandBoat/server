-----------------------------------
-- Garrison Placeholder NPCs
--
-- Sets placeholder NPCs for Garrison for use in lieu of capture data.
-- This is a temporary work around. Please contribute capture data!
-- The correct data should be added to: globals/garrison_data.lua
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("garrison_placeholder_npcs")

-- Name is Determined by Nation and LevelCap
-- Names in order of xi.nation values (sandoria, bastok, windurst)
local allyNames =
{
    [20] = { "Patrician",       "Recruit",         "Candidate"       },
    [30] = { "Trader",          "Mariner",         "Scholar"         },
    [40] = { "TempleKnight",    "GoldMusketeer",   "Mercenary"       }, -- Missing capture for Windurst 40
    [50] = { "RoyalGuard",      "GoldMusketeer",   "Patriarch"       },
    [75] = { "MilitaryAttache", "MilitaryAttache", "MilitaryAttache" },
}

-- Group Ids are different per cap due to min / max level requirements
-- They all use the same pool at the moment, but we could also change families
-- based on cap, which would change base stats
local allyGroupIds =
{
    [20] = 1,
    [30] = 2,
    [40] = 3,
    [50] = 4,
    [75] = 5,
}

-- Look is Determined by Nation and LevelCap (Appears to be 4 for each outpost - More data needed)
-- The looks that have not been obtained from captures are commented with the npc that they are taken from
local allyLooks =
{
    [20] =
    {
        [xi.nation.SANDORIA] =
        {
            "0x01000C030010262000303A403A5008611B700000",
            "0x01000A040010262019303A40195008611C700000",
            "0x010004041C106E20833080406850836083700000", -- Fouagine
        },

        [xi.nation.BASTOK] =
        {
            "0x0100040100100520163005400550B86000700000", -- Pavel
            "0x0100000100100620063006400650006000700000", -- Caliburn
            "0x0100030100100520163005400550B86000700000", -- Fariel
        },

        [xi.nation.WINDURST] =
        {
            "0x0100180618101820183018401850006000700000", -- Mokyokyo
            "0x0100040600100120013001400150006000700000", -- Shatoto
            "0x0100030601100120013001400150016001700000", -- Harara_WW
        },
    },
    [30] =
    {
        [xi.nation.SANDORIA] =
        {
            "0x010006030010762076303A400650736000700000",
            "0x01000F0300101520153015401550006000700000",
            "0x010009040010762076303A400650736000700000",
            "0x01000E0400101520003015401550006000700000",
        },

        [xi.nation.BASTOK] =
        {
            "0x0100010814102720173015401550006000700000", -- Ferocious_Artisan
            "0x01000E020F100720003003400750006000700000", -- Suzel
            "0x010003011C100E20083068401F50626000700000", -- Guda (16883811)
        },

        [xi.nation.WINDURST] =
        {
            "0x0100040600100120013001400150006000700000", -- Shatoto
            "0x0100030601100120013001400150016001700000", -- Harara_WW
            "0x0100040777106720683066406850006000700000", -- AMAN_Reclaimer (17764605)
            "0x0100020700100220023002400250006000700000", -- Naih_Arihmepp
        },
    },
    [40] =
    {
        [xi.nation.SANDORIA] =
        {
            "0x01000E04191019201930194019506B601C700000",
            "0x01000903191019201930194019506B601C700000",
            "0x010009081C108A2008308A40085019611D700000", -- Ironclad_Gorilla
        },

        [xi.nation.BASTOK] =
        {
            "0x0100020260102420603060406050B56000700000",
            "0x010008083D1024203D3010401050756075700000",
            "0x01000008371024203730374037506F6018700000",
            "0x0100040105102420053005400550BB6000700000",
        },

        [xi.nation.WINDURST] =
        {
            "0x01000C05141019200C3002400250006000700000", -- Voidwatch officer (17752374)
            "0x0100000500100220023002400250006000700000", -- Taraihi-Perunhi
            "0x01000306461118205230B8408550006000700000", -- Wetata
        },
    },
    [50] =
    {
        [xi.nation.SANDORIA] =
        {
            "0x01000A041C103C206C306C406C503C6000700000", -- Ferchinne
            "0x01000D0323108A20803088408050056100700000", -- Parelbriaux
            "0x01000101141019200C3002400250056000700000", -- Petva
        },

        [xi.nation.BASTOK] =
        {
            "0x01000C011C1073208330804068504E6000700000", -- Masis (16883819)
            "0x010009081C108A2008308A40085019611D700000", -- Ironclad_Gorilla
            "0x01000D0801101620053019400C505C6000700000", -- Iron Eater (17748016)
        },

        [xi.nation.WINDURST] =
        {
            "0x0100020600106320633063406350056122700000",
            "0x010004067C102D20193019401950506100700000",
            "0x0100080669106B206B306B406B50FE6000700000",
        },
    },
    [75] =
    {
        [xi.nation.SANDORIA] =
        {
            "0x010009031A10812088303C408850CF6000700000", -- Morangeart
            "0x01000E0388108820883088408850186100700000", -- Quelveuiat
            "0x01000F0304102220093009400950006000700000", -- Jaucribaix
        },

        [xi.nation.BASTOK] =
        {
            "0x010002071C1070201C301C401C50C46000700000",
            "0x010008021C106A20733073406850006000700000", -- Merol
        },

        [xi.nation.WINDURST] =
        {
            "0x010003071310222064306E406450006000700000", -- Fhelm_Jobeizat (17764603)
            "0x0100080604102320093009400C50006000700000", -- Shivivi
        },
    },
}

-- This is used to replace blank weapons in ally looks.
-- TODO: Use proper npc looks for all models or at least find the right range
-- so we can purely generate these
local allyArsenal =
{
    "08",
    "83",
    "B8",
    "73",
    "62",
    "01",
    "19",
    "6B",
    "B5",
    "75",
    "6F",
    "BB",
    "3C",
    "56",
    "4E",
    "19",
    "5C",
    "61",
    "E6",
}

-- Adds a random weapon if the given look does not contain one.
-- Weapons are on the byte found in digits 31-32 (including 0x prefix)
local function addWeaponIfNecessary(look)
    -- Weapon already set. Don't change it.
    if string.sub(look, 31, 32) ~= "00" then
        return look
    end

    local weapon = utils.randomEntry(allyArsenal)

    return string.sub(look, 1, 30) .. weapon .. string.sub(look, 33, string.len(look))
end

m:addOverride("xi.garrison.getAllyInfo", function(zoneData, nationID)
    local zoneAllyName    = allyNames[zoneData.levelCap][nationID]
    local zoneAllyLooks   = allyLooks[zoneData.levelCap][nationID]
    local zoneAllyGroupId = allyGroupIds[zoneData.levelCap]

    for index, allyLook in pairs(zoneAllyLooks) do
        zoneAllyLooks[index] = addWeaponIfNecessary(allyLook)
    end

    return {
        name    = zoneAllyName,
        looks   = zoneAllyLooks,
        groupId = zoneAllyGroupId,
    }
end)

return m
