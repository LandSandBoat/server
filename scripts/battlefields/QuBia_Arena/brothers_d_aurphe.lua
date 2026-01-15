-----------------------------------
-- Brothers D'Aurphe
-- Qu'Bia Arena BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.QUBIA_ARENA,
    battlefieldId    = xi.battlefield.id.BROTHERS_D_AURPHE,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(30),
    index            = 11,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.MOON_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Vaicoliaux_B_DAurphe', 'Maldaramet_B_DAurphe', 'Disfaurit_B_DAurphe', 'Jeumouque_B_DAurphe' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                       weight = 10000, amount = 18000 },
    },

    {
        { itemId = xi.item.NONE,                      weight =  8000 },
        { itemId = xi.item.CROSS_COUNTERS,            weight =  1000 },
        { itemId = xi.item.EURYTOS_BOW,               weight =  1000 },
    },

    {
        { itemId = xi.item.CREEK_M_CLOMPS,            weight =  1250 },
        { itemId = xi.item.CREEK_F_CLOMPS,            weight =  1250 },
        { itemId = xi.item.MARINE_M_BOOTS,            weight =  1250 },
        { itemId = xi.item.MARINE_F_BOOTS,            weight =  1250 },
        { itemId = xi.item.WOOD_M_LEDELSENS,          weight =  1250 },
        { itemId = xi.item.WOOD_F_LEDELSENS,          weight =  1250 },
        { itemId = xi.item.DUNE_SANDALS,              weight =  1250 },
        { itemId = xi.item.RIVER_GAITERS,             weight =  1250 },
    },

    {
        { itemId = xi.item.BLACK_CHIP,                weight =   200 },
        { itemId = xi.item.BLUE_CHIP,                 weight =   200 },
        { itemId = xi.item.CLEAR_CHIP,                weight =   200 },
        { itemId = xi.item.GREEN_CHIP,                weight =   200 },
        { itemId = xi.item.PURPLE_CHIP,               weight =   200 },
        { itemId = xi.item.RED_CHIP,                  weight =   200 },
        { itemId = xi.item.WHITE_CHIP,                weight =   200 },
        { itemId = xi.item.YELLOW_CHIP,               weight =   200 },
        { itemId = xi.item.AQUAMARINE,                weight =   350 },
        { itemId = xi.item.CHRYSOBERYL,               weight =   350 },
        { itemId = xi.item.FLUORITE,                  weight =   350 },
        { itemId = xi.item.JADEITE,                   weight =   350 },
        { itemId = xi.item.MOONSTONE,                 weight =   350 },
        { itemId = xi.item.PAINITE,                   weight =   350 },
        { itemId = xi.item.SUNSTONE,                  weight =   350 },
        { itemId = xi.item.ZIRCON,                    weight =   350 },
        { itemId = xi.item.BLACK_ROCK,                weight =   350 },
        { itemId = xi.item.BLUE_ROCK,                 weight =   350 },
        { itemId = xi.item.GREEN_ROCK,                weight =   350 },
        { itemId = xi.item.PURPLE_ROCK,               weight =   350 },
        { itemId = xi.item.RED_ROCK,                  weight =   350 },
        { itemId = xi.item.TRANSLUCENT_ROCK,          weight =   350 },
        { itemId = xi.item.WHITE_ROCK,                weight =   350 },
        { itemId = xi.item.YELLOW_ROCK,               weight =   350 },
        { itemId = xi.item.EBONY_LOG,                 weight =   350 },
        { itemId = xi.item.MAHOGANY_LOG,              weight =   350 },
        { itemId = xi.item.CORAL_FRAGMENT,            weight =   350 },
        { itemId = xi.item.DARKSTEEL_INGOT,           weight =   350 },
        { itemId = xi.item.DEMON_HORN,                weight =   350 },
        { itemId = xi.item.GOLD_INGOT,                weight =   350 },
        { itemId = xi.item.MYTHRIL_INGOT,             weight =   350 },
        { itemId = xi.item.STEEL_INGOT,               weight =   350 },
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
        { itemId = xi.item.HI_RERAISER,               weight =   200 },
        { itemId = xi.item.VILE_ELIXIR_P1,            weight =   200 },
    },

    {
        { itemId = xi.item.SCROLL_OF_FLARE,           weight =  3333 },
        { itemId = xi.item.SCROLL_OF_VALOR_MINUET_IV, weight =  3333 },
        { itemId = xi.item.SCROLL_OF_RERAISE_II,      weight =  3334 },
    },
}

return content:register()
