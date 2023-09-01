-----------------------------------
-- Garrison Placeholder Data
--
-- Sets placeholder NPCs and mob data for Garrison for use in lieu of captures.
-- This is a temporary work around. Please contribute capture data!
-- The correct data should be added to: globals/garrison_data.lua
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('garrison_placeholder_data')

local additionalAllyLooks =
{
    [20] =
    {
        [xi.nation.SANDORIA] =
        {
            '0x010004041C106E20833080406850836083700000', -- Fouagine
            '0x01000A041C103C206C306C406C503C6000700000', -- Ferchinne
        },

        [xi.nation.BASTOK] =
        {
            --
        },

        [xi.nation.WINDURST] =
        {
            '0x0100030601100120013001400150016001700000', -- Harara_WW
        },
    },
    [30] =
    {
        [xi.nation.SANDORIA] =
        {
            --
        },

        [xi.nation.BASTOK] =
        {
            '0x01000E020F100720003003400750006000700000', -- Suzel
        },

        [xi.nation.WINDURST] =
        {
            --
        },
    },
    [40] =
    {
        [xi.nation.SANDORIA] =
        {
            '0x01000D0323108A20803088408050056100700000', -- Parelbriaux
            '0x01000101141019200C3002400250056000700000', -- Petva
        },

        [xi.nation.BASTOK] =
        {
            --
        },

        [xi.nation.WINDURST] =
        {
            '0x0100000500100220023002400250006000700000', -- Taraihi-Perunhi
            '0x01000306461118205230B8408550006000700000', -- Wetata
        },
    },
    [50] =
    {
        [xi.nation.SANDORIA] =
        {
            --
        },

        [xi.nation.BASTOK] =
        {
            '0x01000D0801101620053019400C505C6000700000', -- Iron Eater (17748016)
            '0x0100010814102720173015401550006000700000', -- Ferocious_Artisan
        },

        [xi.nation.WINDURST] =
        {
            '0x0100020700100220023002400250006000700000', -- Naih_Arihmepp
        },
    },
    [99] =
    {
        [xi.nation.SANDORIA] =
        {
            --
        },

        [xi.nation.BASTOK] =
        {
            --
            '0x010008021C106A20733073406850006000700000', -- Merol
        },

        [xi.nation.WINDURST] =
        {
            --
        },
    },
}

-- This is used to replace blank weapons in ally looks.
-- TODO: Use proper npc looks for all models or at least find the right range
-- so we can purely generate these
local allyArsenal =
{
    '08',
    '83',
    'B8',
    '73',
    '62',
    '01',
    '19',
    '6B',
    'B5',
    '75',
    '6F',
    'BB',
    '3C',
    '56',
    '4E',
    '19',
    '5C',
    '61',
    'E6',
}

-- Adds a random weapon if the given look does not contain one.
-- Weapons are on the byte found in digits 31-32 (including 0x prefix)
local function addWeaponIfNecessary(look)
    -- Weapon already set. Don't change it.
    if string.sub(look, 31, 32) ~= '00' then
        return look
    end

    local weapon = utils.randomEntry(allyArsenal)

    return string.sub(look, 1, 30) .. weapon .. string.sub(look, 33, string.len(look))
end

m:addOverride('xi.garrison.getAllyInfo', function(zoneID, zoneData, nationID)
    -- Get the original allyInfo table (getAllyInfo() returns a temporary, so it's safe to
    -- modify it in-flight)
    local allyInfoTable = super(zoneID, zoneData, nationID)

    -- Augment it with additional looks from additionalAllyLooks and addWeaponIfNecessary()
    for _, lookCode in pairs(additionalAllyLooks[zoneData.levelCap][nationID]) do
        local updatedLookCode = addWeaponIfNecessary(lookCode)
        table.insert(allyInfoTable.looks, updatedLookCode)
    end

    return allyInfoTable
end)

return m
