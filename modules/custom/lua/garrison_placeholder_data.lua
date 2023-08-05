-----------------------------------
-- Garrison Placeholder Data
--
-- Sets placeholder NPCs and mob data for Garrison for use in lieu of captures.
-- This is a temporary work around. Please contribute capture data!
-- The correct data should be added to: globals/garrison_data.lua
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("garrison_placeholder_data")

-- Name is Determined by Nation and LevelCap
-- Names in order of xi.nation values (sandoria, bastok, windurst)
local allyNames =
{
    [20] = { "Patrician",       "Recruit",         "Candidate"       },
    [30] = { "Trader",          "Mariner",         "Scholar"         },
    [40] = { "TempleKnight",    "GoldMusketeer",   "WizeWizard"      },
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
            "0x01000E02000066000100010001009F0000000000",
            "0x010001017D000000150015001500B70000000000",
            "0x01000701361005206630664066500C6129700000",
            "0x0100020103000300000000000000DC0000000000",
            "0x010006020F0000000F000F000F00820082000000",
            "0x01000402740014000000000003002C0100000000",
        },

        [xi.nation.WINDURST] =
        {
            "0x010007070110322032300E401550AC6000700000",
            "0x01000E0718101820183015401850B76024700000",
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
            "0x01000B051C1073201430144014506C6000700000",
            "0x0100010777106920693066406950B46000700000",
            "0x010000067D107820033066406850E96000700000",
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

local posData =
{
    [xi.zone.WEST_RONFAURE]          = { -438, -20, -223,   0 },
    [xi.zone.NORTH_GUSTABERG]        = { -575,  40,   63,   0 },
    [xi.zone.WEST_SARUTABARUTA]      = {  -21, -12,  327, 128 },
    [xi.zone.VALKURM_DUNES]          = {  149,  -8,   94,  32 },
    [xi.zone.JUGNER_FOREST]          = {   54,   1,   -1, 210 }, -- Needs capture
    [xi.zone.PASHHOW_MARSHLANDS]     = {  458,  24,  421, 130 }, -- Needs capture
    [xi.zone.BUBURIMU_PENINSULA]     = { -485, -29,   58,   0 }, -- Needs capture
    [xi.zone.MERIPHATAUD_MOUNTAINS]  = { -299,  17,  411,  30 }, -- Needs capture
    [xi.zone.QUFIM_ISLAND]           = { -247, -19,  310,   0 }, -- Needs capture
    [xi.zone.BEAUCEDINE_GLACIER]     = {  -25, -60, -110, 220 }, -- Needs capture
    [xi.zone.THE_SANCTUARY_OF_ZITAH] = {  -43,   1, -140, 180 },
    [xi.zone.YUHTUNGA_JUNGLE]        = { -248,   1, -392, 180 },
    [xi.zone.XARCABARD]              = {  216, -22,  208,  90 }, -- Needs capture
    [xi.zone.EASTERN_ALTEPA_DESERT]  = { -245,  -9, -249,   0 },
    [xi.zone.YHOATOR_JUNGLE]         = {  214,   1,  -80,   0 },
    [xi.zone.CAPE_TERIGGAN]          = { -174,   8,  -61,   0 },
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

m:addOverride("xi.garrison.getMobInfo", function(zone)
    local zoneID = zone:getID()

    return {
        pos = posData[zoneID]
    }
end)

return m
