-----------------------------------
-- Dismemberment Brigade
-- Horlais Peak BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.DISMEMBERMENT_BRIGADE,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.MOON_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        horlaisID.mob.ARMSMASTER_DEKBUK + 6,
        horlaisID.mob.ARMSMASTER_DEKBUK + 13,
        horlaisID.mob.ARMSMASTER_DEKBUK + 20,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                horlaisID.mob.ARMSMASTER_DEKBUK,
                horlaisID.mob.ARMSMASTER_DEKBUK + 1,
                horlaisID.mob.ARMSMASTER_DEKBUK + 2,
                horlaisID.mob.ARMSMASTER_DEKBUK + 3,
                horlaisID.mob.ARMSMASTER_DEKBUK + 4,
                horlaisID.mob.ARMSMASTER_DEKBUK + 5,
            },

            {
                horlaisID.mob.ARMSMASTER_DEKBUK + 7,
                horlaisID.mob.ARMSMASTER_DEKBUK + 8,
                horlaisID.mob.ARMSMASTER_DEKBUK + 9,
                horlaisID.mob.ARMSMASTER_DEKBUK + 10,
                horlaisID.mob.ARMSMASTER_DEKBUK + 11,
                horlaisID.mob.ARMSMASTER_DEKBUK + 12,
            },

            {
                horlaisID.mob.ARMSMASTER_DEKBUK + 14,
                horlaisID.mob.ARMSMASTER_DEKBUK + 15,
                horlaisID.mob.ARMSMASTER_DEKBUK + 16,
                horlaisID.mob.ARMSMASTER_DEKBUK + 17,
                horlaisID.mob.ARMSMASTER_DEKBUK + 18,
                horlaisID.mob.ARMSMASTER_DEKBUK + 19,
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
        { itemId = xi.item.KABRAKANS_AXE,             weight =  2500 },
        { itemId = xi.item.SARNGA,                    weight =  2500 },
        { itemId = xi.item.DRAGVANDIL,                weight =  2500 },
        { itemId = xi.item.HAMELIN_FLUTE,             weight =  2500 },
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
        { itemId = xi.item.PEACE_RING,                weight =  4000 },
        { itemId = xi.item.SPECTACLES,                weight =  2000 },
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
