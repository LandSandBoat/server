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
        { itemId = xi.item.GIL,                       weight = 10000, amount = 18000 },
    },

    {
        { itemId = xi.item.ARCHALAUSS_POLE,           weight =  2500 },
        { itemId = xi.item.CHICKEN_KNIFE,             weight =  2500 },
        { itemId = xi.item.FEY_WAND,                  weight =  2500 },
        { itemId = xi.item.VASSAGOS_SCYTHE,           weight =  2500 },
    },

    {
        { itemId = xi.item.AQUAMARINE,                weight =   400 },
        { itemId = xi.item.CHRYSOBERYL,               weight =   400 },
        { itemId = xi.item.FLUORITE,                  weight =   400 },
        { itemId = xi.item.JADEITE,                   weight =   400 },
        { itemId = xi.item.MOONSTONE,                 weight =   400 },
        { itemId = xi.item.PAINITE,                   weight =   400 },
        { itemId = xi.item.SUNSTONE,                  weight =   400 },
        { itemId = xi.item.ZIRCON,                    weight =   400 },
        { itemId = xi.item.BLACK_ROCK,                weight =   400 },
        { itemId = xi.item.BLUE_ROCK,                 weight =   400 },
        { itemId = xi.item.GREEN_ROCK,                weight =   400 },
        { itemId = xi.item.PURPLE_ROCK,               weight =   400 },
        { itemId = xi.item.RED_ROCK,                  weight =   400 },
        { itemId = xi.item.TRANSLUCENT_ROCK,          weight =   400 },
        { itemId = xi.item.WHITE_ROCK,                weight =   400 },
        { itemId = xi.item.YELLOW_ROCK,               weight =   400 },
        { itemId = xi.item.EBONY_LOG,                 weight =   400 },
        { itemId = xi.item.ROSEWOOD_LOG,              weight =   400 },
        { itemId = xi.item.MAHOGANY_LOG,              weight =   400 },
        { itemId = xi.item.DARKSTEEL_INGOT,           weight =   400 },
        { itemId = xi.item.GOLD_INGOT,                weight =   400 },
        { itemId = xi.item.MYTHRIL_INGOT,             weight =   400 },
        { itemId = xi.item.STEEL_INGOT,               weight =   400 },
        { itemId = xi.item.DEMON_HORN,                weight =   400 },
        { itemId = xi.item.CORAL_FRAGMENT,            weight =   400 },
    },

    {
        { itemId = xi.item.ASSAULT_EARRING,           weight =  4000 },
        { itemId = xi.item.ENHANCING_MANTLE,          weight =  4000 },
        { itemId = xi.item.ASTRAL_SHIELD,             weight =  2000 },
    },

    {
        { itemId = xi.item.AQUAMARINE,                weight =   400 },
        { itemId = xi.item.CHRYSOBERYL,               weight =   400 },
        { itemId = xi.item.FLUORITE,                  weight =   400 },
        { itemId = xi.item.JADEITE,                   weight =   400 },
        { itemId = xi.item.MOONSTONE,                 weight =   400 },
        { itemId = xi.item.PAINITE,                   weight =   400 },
        { itemId = xi.item.SUNSTONE,                  weight =   400 },
        { itemId = xi.item.ZIRCON,                    weight =   400 },
        { itemId = xi.item.BLACK_ROCK,                weight =   400 },
        { itemId = xi.item.BLUE_ROCK,                 weight =   400 },
        { itemId = xi.item.GREEN_ROCK,                weight =   400 },
        { itemId = xi.item.PURPLE_ROCK,               weight =   400 },
        { itemId = xi.item.RED_ROCK,                  weight =   400 },
        { itemId = xi.item.TRANSLUCENT_ROCK,          weight =   400 },
        { itemId = xi.item.WHITE_ROCK,                weight =   400 },
        { itemId = xi.item.YELLOW_ROCK,               weight =   400 },
        { itemId = xi.item.EBONY_LOG,                 weight =   400 },
        { itemId = xi.item.MAHOGANY_LOG,              weight =   400 },
        { itemId = xi.item.DARKSTEEL_INGOT,           weight =   400 },
        { itemId = xi.item.GOLD_INGOT,                weight =   400 },
        { itemId = xi.item.MYTHRIL_INGOT,             weight =   400 },
        { itemId = xi.item.STEEL_INGOT,               weight =   400 },
        { itemId = xi.item.DEMON_HORN,                weight =   400 },
        { itemId = xi.item.CORAL_FRAGMENT,            weight =   400 },
        { itemId = xi.item.HI_RERAISER,               weight =   400 },
    },

    {
        { itemId = xi.item.AQUAMARINE,                weight =   400 },
        { itemId = xi.item.CHRYSOBERYL,               weight =   400 },
        { itemId = xi.item.FLUORITE,                  weight =   400 },
        { itemId = xi.item.JADEITE,                   weight =   400 },
        { itemId = xi.item.MOONSTONE,                 weight =   400 },
        { itemId = xi.item.PAINITE,                   weight =   400 },
        { itemId = xi.item.SUNSTONE,                  weight =   400 },
        { itemId = xi.item.ZIRCON,                    weight =   400 },
        { itemId = xi.item.BLACK_ROCK,                weight =   400 },
        { itemId = xi.item.BLUE_ROCK,                 weight =   400 },
        { itemId = xi.item.GREEN_ROCK,                weight =   400 },
        { itemId = xi.item.PURPLE_ROCK,               weight =   400 },
        { itemId = xi.item.RED_ROCK,                  weight =   400 },
        { itemId = xi.item.TRANSLUCENT_ROCK,          weight =   400 },
        { itemId = xi.item.WHITE_ROCK,                weight =   400 },
        { itemId = xi.item.YELLOW_ROCK,               weight =   400 },
        { itemId = xi.item.EBONY_LOG,                 weight =   400 },
        { itemId = xi.item.MAHOGANY_LOG,              weight =   400 },
        { itemId = xi.item.DARKSTEEL_INGOT,           weight =   400 },
        { itemId = xi.item.GOLD_INGOT,                weight =   400 },
        { itemId = xi.item.MYTHRIL_INGOT,             weight =   400 },
        { itemId = xi.item.STEEL_INGOT,               weight =   400 },
        { itemId = xi.item.DEMON_HORN,                weight =   400 },
        { itemId = xi.item.CORAL_FRAGMENT,            weight =   400 },
        { itemId = xi.item.VILE_ELIXIR_P1,            weight =   400 },
    },

    {
        { itemId = xi.item.AQUAMARINE,                weight =   400 },
        { itemId = xi.item.CHRYSOBERYL,               weight =   400 },
        { itemId = xi.item.FLUORITE,                  weight =   400 },
        { itemId = xi.item.JADEITE,                   weight =   400 },
        { itemId = xi.item.MOONSTONE,                 weight =   400 },
        { itemId = xi.item.PAINITE,                   weight =   400 },
        { itemId = xi.item.SUNSTONE,                  weight =   400 },
        { itemId = xi.item.ZIRCON,                    weight =   400 },
        { itemId = xi.item.BLACK_ROCK,                weight =   400 },
        { itemId = xi.item.BLUE_ROCK,                 weight =   400 },
        { itemId = xi.item.GREEN_ROCK,                weight =   400 },
        { itemId = xi.item.PURPLE_ROCK,               weight =   400 },
        { itemId = xi.item.RED_ROCK,                  weight =   400 },
        { itemId = xi.item.TRANSLUCENT_ROCK,          weight =   400 },
        { itemId = xi.item.WHITE_ROCK,                weight =   400 },
        { itemId = xi.item.YELLOW_ROCK,               weight =   400 },
        { itemId = xi.item.ROSEWOOD_LOG,              weight =   400 },
        { itemId = xi.item.EBONY_LOG,                 weight =   400 },
        { itemId = xi.item.MAHOGANY_LOG,              weight =   400 },
        { itemId = xi.item.DARKSTEEL_INGOT,           weight =   400 },
        { itemId = xi.item.GOLD_INGOT,                weight =   400 },
        { itemId = xi.item.MYTHRIL_INGOT,             weight =   400 },
        { itemId = xi.item.STEEL_INGOT,               weight =   400 },
        { itemId = xi.item.DEMON_HORN,                weight =   400 },
        { itemId = xi.item.CORAL_FRAGMENT,            weight =   400 },
    },
}

return content:register()
