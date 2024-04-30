-----------------------------------
-- Grimshell Shocktroopers
-- Waughroon Shrine BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.GRIMSHELL_SHOCKTROOPERS,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.MOON_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        waughroonID.mob.YOBHU_HIDEOUSMASK + 6,
        waughroonID.mob.YOBHU_HIDEOUSMASK + 13,
        waughroonID.mob.YOBHU_HIDEOUSMASK + 20,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                waughroonID.mob.YOBHU_HIDEOUSMASK,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 1,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 2,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 3,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 4,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 5,
            },

            {
                waughroonID.mob.YOBHU_HIDEOUSMASK + 7,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 8,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 9,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 10,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 11,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 12,
            },

            {
                waughroonID.mob.YOBHU_HIDEOUSMASK + 14,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 15,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 16,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 17,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 18,
                waughroonID.mob.YOBHU_HIDEOUSMASK + 19,
            },
        },

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

content.loot =
{
    {
        { item = xi.item.NONE,             weight = 250 }, -- nothing
        { item = xi.item.ASSAULT_EARRING,  weight = 125 }, -- assault_earring
        { item = xi.item.VASSAGOS_SCYTHE,  weight = 125 }, -- vassagos_scythe
        { item = xi.item.CHICKEN_KNIFE,    weight = 125 }, -- chicken_knife
        { item = xi.item.FEY_WAND,         weight = 125 }, -- fey_wand
        { item = xi.item.ASTRAL_SHIELD,    weight = 125 }, -- astral_shield
        { item = xi.item.ENHANCING_MANTLE, weight = 125 }, -- enhancing_mantle
    },

    {
        { item = xi.item.MYTHRIL_INGOT,   weight = 250 }, -- mythril_ingot
        { item = xi.item.STEEL_INGOT,     weight = 250 }, -- steel_ingot
        { item = xi.item.GOLD_INGOT,      weight = 250 }, -- gold_ingot
        { item = xi.item.DARKSTEEL_INGOT, weight = 250 }, -- darksteel_ingot
    },

    {
        { item = xi.item.EBONY_LOG,     weight = 250 }, -- ebony_log
        { item = xi.item.CHRYSOBERYL,   weight = 250 }, -- chrysoberyl
        { item = xi.item.FLUORITE,      weight = 250 }, -- fluorite
        { item = xi.item.DREAM_PLATTER, weight = 250 }, -- jadeite
    },

    {
        { item = xi.item.NONE,               weight = 875 }, -- nothing
        { item = xi.item.SCROLL_OF_RAISE_II, weight = 125 }, -- scroll_of_raise_ii
    },

    {
        { item = xi.item.NONE,               weight = 800 }, -- nothing
        { item = xi.item.SCROLL_OF_RAISE_II, weight = 200 }, -- hi-reraiser
    },
}

return content:register()
