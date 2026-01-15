-----------------------------------
-- Divine Punishers
-- Balga's Dais BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.DIVINE_PUNISHERS,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.MOON_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 6,
        balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 13,
        balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 20,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 1,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 2,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 3,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 4,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 5,
            },

            {
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 7,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 8,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 9,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 10,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 11,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 12,
            },

            {
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 14,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 15,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 16,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 17,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 18,
                balgasID.mob.VOO_TOLU_THE_GHOSTFIST + 19,
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
        { itemId = xi.item.FORSETIS_AXE,              weight =  2500 },
        { itemId = xi.item.ARAMISS_RAPIER,            weight =  2500 },
        { itemId = xi.item.SPARTAN_CESTI,             weight =  2500 },
        { itemId = xi.item.DOMINION_MACE,             weight =  2500 },
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
        { itemId = xi.item.PEACE_RING,                weight =  4000 },
        { itemId = xi.item.ENHANCING_MANTLE,          weight =  4000 },
        { itemId = xi.item.MASTER_BELT,               weight =  2000 },
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

    {
        { itemId = xi.item.NONE,                      weight =  8000 },
        { itemId = xi.item.FUMA_KYAHAN,               weight =  1000 },
        { itemId = xi.item.OCHIUDOS_KOTE,             weight =  1000 },
    },

}

return content:register()
