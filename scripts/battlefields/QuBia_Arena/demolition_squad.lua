-----------------------------------
-- Demolition Squad
-- Qu'Bia Arena BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.DEMOLITION_SQUAD,
    maxPlayers    = 6,
    levelCap      = 60,
    timeLimit     = utils.minutes(30),
    index         = 8,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.MOON_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Nephiyl_Rampartbreacher', 'Nephiyl_Keepcollapser', 'Nephiyl_Moatfiller', 'Nephiyl_Pinnacletosser' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                       weight = 10000, amount = 18000 },
    },

    {
        { itemId = xi.item.MARINE_M_GLOVES,           weight =  1250 },
        { itemId = xi.item.MARINE_F_GLOVES,           weight =  1250 },
        { itemId = xi.item.WOOD_GAUNTLETS,            weight =  1250 },
        { itemId = xi.item.WOOD_GLOVES,               weight =  1250 },
        { itemId = xi.item.CREEK_M_MITTS,             weight =  1250 },
        { itemId = xi.item.CREEK_F_MITTS,             weight =  1250 },
        { itemId = xi.item.RIVER_GAUNTLETS,           weight =  1250 },
        { itemId = xi.item.DUNE_BRACERS,              weight =  1250 },
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
