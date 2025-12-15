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
        { itemId = xi.item.GIL,                       weight = 1000, amount = 18000 },
    },

    {
        { itemId = xi.item.MARINE_M_GLOVES,           weight = 125 },
        { itemId = xi.item.MARINE_F_GLOVES,           weight = 125 },
        { itemId = xi.item.WOOD_GAUNTLETS,            weight = 125 },
        { itemId = xi.item.WOOD_GLOVES,               weight = 125 },
        { itemId = xi.item.CREEK_M_MITTS,             weight = 125 },
        { itemId = xi.item.CREEK_F_MITTS,             weight = 125 },
        { itemId = xi.item.RIVER_GAUNTLETS,           weight = 125 },
        { itemId = xi.item.DUNE_BRACERS,              weight = 125 },
    },

    {
        { itemId = xi.item.BLACK_CHIP,                weight = 20 },
        { itemId = xi.item.BLUE_CHIP,                 weight = 20 },
        { itemId = xi.item.CLEAR_CHIP,                weight = 20 },
        { itemId = xi.item.GREEN_CHIP,                weight = 20 },
        { itemId = xi.item.PURPLE_CHIP,               weight = 20 },
        { itemId = xi.item.RED_CHIP,                  weight = 20 },
        { itemId = xi.item.WHITE_CHIP,                weight = 20 },
        { itemId = xi.item.YELLOW_CHIP,               weight = 20 },
        { itemId = xi.item.AQUAMARINE,                weight = 35 },
        { itemId = xi.item.CHRYSOBERYL,               weight = 35 },
        { itemId = xi.item.FLUORITE,                  weight = 35 },
        { itemId = xi.item.JADEITE,                   weight = 35 },
        { itemId = xi.item.MOONSTONE,                 weight = 35 },
        { itemId = xi.item.PAINITE,                   weight = 35 },
        { itemId = xi.item.SUNSTONE,                  weight = 35 },
        { itemId = xi.item.ZIRCON,                    weight = 35 },
        { itemId = xi.item.BLACK_ROCK,                weight = 35 },
        { itemId = xi.item.BLUE_ROCK,                 weight = 35 },
        { itemId = xi.item.GREEN_ROCK,                weight = 35 },
        { itemId = xi.item.PURPLE_ROCK,               weight = 35 },
        { itemId = xi.item.RED_ROCK,                  weight = 35 },
        { itemId = xi.item.TRANSLUCENT_ROCK,          weight = 35 },
        { itemId = xi.item.WHITE_ROCK,                weight = 35 },
        { itemId = xi.item.YELLOW_ROCK,               weight = 35 },
        { itemId = xi.item.EBONY_LOG,                 weight = 35 },
        { itemId = xi.item.MAHOGANY_LOG,              weight = 35 },
        { itemId = xi.item.CORAL_FRAGMENT,            weight = 35 },
        { itemId = xi.item.DARKSTEEL_INGOT,           weight = 35 },
        { itemId = xi.item.DEMON_HORN,                weight = 35 },
        { itemId = xi.item.GOLD_INGOT,                weight = 35 },
        { itemId = xi.item.MYTHRIL_INGOT,             weight = 35 },
        { itemId = xi.item.STEEL_INGOT,               weight = 35 },
    },

    {
        { itemId = xi.item.AQUAMARINE,                weight = 25 },
        { itemId = xi.item.CHRYSOBERYL,               weight = 25 },
        { itemId = xi.item.FLUORITE,                  weight = 25 },
        { itemId = xi.item.JADEITE,                   weight = 25 },
        { itemId = xi.item.MOONSTONE,                 weight = 25 },
        { itemId = xi.item.PAINITE,                   weight = 25 },
        { itemId = xi.item.SUNSTONE,                  weight = 25 },
        { itemId = xi.item.ZIRCON,                    weight = 25 },
        { itemId = xi.item.BLACK_ROCK,                weight = 25 },
        { itemId = xi.item.BLUE_ROCK,                 weight = 25 },
        { itemId = xi.item.GREEN_ROCK,                weight = 25 },
        { itemId = xi.item.PURPLE_ROCK,               weight = 25 },
        { itemId = xi.item.RED_ROCK,                  weight = 25 },
        { itemId = xi.item.TRANSLUCENT_ROCK,          weight = 25 },
        { itemId = xi.item.WHITE_ROCK,                weight = 25 },
        { itemId = xi.item.YELLOW_ROCK,               weight = 25 },
        { itemId = xi.item.EBONY_LOG,                 weight = 25 },
        { itemId = xi.item.MAHOGANY_LOG,              weight = 25 },
        { itemId = xi.item.DARKSTEEL_INGOT,           weight = 25 },
        { itemId = xi.item.GOLD_INGOT,                weight = 25 },
        { itemId = xi.item.MYTHRIL_INGOT,             weight = 25 },
        { itemId = xi.item.STEEL_INGOT,               weight = 25 },
        { itemId = xi.item.HI_RERAISER,               weight = 25 },
        { itemId = xi.item.VILE_ELIXIR,               weight = 25 },
        { itemId = xi.item.VILE_ELIXIR_P1,            weight = 25 },
        { itemId = xi.item.DEMON_HORN,                weight = 25 },
        { itemId = xi.item.CORAL_FRAGMENT,            weight = 25 },
    },

    {
        { itemId = xi.item.SCROLL_OF_FLARE,           weight = 333 },
        { itemId = xi.item.SCROLL_OF_VALOR_MINUET_IV, weight = 333 },
        { itemId = xi.item.SCROLL_OF_RERAISE_II,      weight = 334 },
    },
}

return content:register()
