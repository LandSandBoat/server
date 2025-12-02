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
    armouryCrates    =
    {
        qubiaID.mob.VAICOLIAUX_B_DAURPHE + 4,
        qubiaID.mob.VAICOLIAUX_B_DAURPHE + 9,
        qubiaID.mob.VAICOLIAUX_B_DAURPHE + 14,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                qubiaID.mob.VAICOLIAUX_B_DAURPHE,
                qubiaID.mob.VAICOLIAUX_B_DAURPHE + 1,
                qubiaID.mob.VAICOLIAUX_B_DAURPHE + 2,
                qubiaID.mob.VAICOLIAUX_B_DAURPHE + 3,
            },

            {
                qubiaID.mob.VAICOLIAUX_B_DAURPHE + 5,
                qubiaID.mob.VAICOLIAUX_B_DAURPHE + 6,
                qubiaID.mob.VAICOLIAUX_B_DAURPHE + 7,
                qubiaID.mob.VAICOLIAUX_B_DAURPHE + 8,
            },

            {
                qubiaID.mob.VAICOLIAUX_B_DAURPHE + 10,
                qubiaID.mob.VAICOLIAUX_B_DAURPHE + 11,
                qubiaID.mob.VAICOLIAUX_B_DAURPHE + 12,
                qubiaID.mob.VAICOLIAUX_B_DAURPHE + 13,
            },
        },

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

content.loot =
{
    {
        { itemId = xi.item.CREEK_M_CLOMPS,   weight = 125 }, -- creek_m_clomps
        { itemId = xi.item.CREEK_F_CLOMPS,   weight = 125 }, -- creek_f_clomps
        { itemId = xi.item.MARINE_M_BOOTS,   weight = 125 }, -- marine_m_boots
        { itemId = xi.item.MARINE_F_BOOTS,   weight = 125 }, -- marine_f_boots
        { itemId = xi.item.WOOD_M_LEDELSENS, weight = 125 }, -- wood_m_ledelsens
        { itemId = xi.item.WOOD_F_LEDELSENS, weight = 125 }, -- wood_f_ledelsens
        { itemId = xi.item.DUNE_SANDALS,     weight = 125 }, -- dune_sandals
        { itemId = xi.item.RIVER_GAITERS,    weight = 125 }, -- river_gaiters
    },

    {
        { itemId = xi.item.CROSS_COUNTERS, weight =  43 }, -- cross-counters
        { itemId = xi.item.CHRYSOBERYL,    weight =  10 }, -- chrysoberyl
        { itemId = xi.item.JADEITE,        weight =  94 }, -- jadeite
        { itemId = xi.item.SUNSTONE,       weight = 113 }, -- sunstone
        { itemId = xi.item.ZIRCON,         weight =  75 }, -- zircon
        { itemId = xi.item.CLEAR_CHIP,     weight =  10 }, -- clear_chip
        { itemId = xi.item.RED_CHIP,       weight =  38 }, -- red_chip
        { itemId = xi.item.YELLOW_CHIP,    weight =  38 }, -- yellow_chip
        { itemId = xi.item.GOLD_INGOT,     weight = 151 }, -- gold_ingot
        { itemId = xi.item.PURPLE_ROCK,    weight =  19 }, -- purple_rock
        { itemId = xi.item.WHITE_ROCK,     weight =  19 }, -- white_rock
    },

    {
        { itemId = xi.item.STEEL_INGOT,      weight = 132 }, -- steel_ingot
        { itemId = xi.item.TRANSLUCENT_ROCK, weight = 113 }, -- translucent_rock
        { itemId = xi.item.DARKSTEEL_INGOT,  weight = 113 }, -- darksteel_ingot
        { itemId = xi.item.PAINITE,          weight =  50 }, -- painite
        { itemId = xi.item.EBONY_LOG,        weight = 132 }, -- ebony_log
        { itemId = xi.item.WHITE_CHIP,       weight =  10 }, -- white_chip
        { itemId = xi.item.MOONSTONE,        weight = 151 }, -- moonstone
        { itemId = xi.item.ZIRCON,           weight =  75 }, -- zircon
        { itemId = xi.item.FLUORITE,         weight =  57 }, -- fluorite
        { itemId = xi.item.CHRYSOBERYL,      weight =  57 }, -- chrysoberyl
        { itemId = xi.item.GREEN_ROCK,       weight =  38 }, -- green_rock
        { itemId = xi.item.HI_RERAISER,      weight =  38 }, -- hi-reraiser
        { itemId = xi.item.VILE_ELIXIR_P1,   weight =  38 }, -- vile_elixir_+1
    },

    {
        { itemId = xi.item.SCROLL_OF_FLARE,           weight = 283 }, -- scroll_of_flare
        { itemId = xi.item.SCROLL_OF_VALOR_MINUET_IV, weight = 358 }, -- scroll_of_valor_minuet_iv
        { itemId = xi.item.SCROLL_OF_RERAISE_II,      weight = 264 }, -- scroll_of_reraise_ii
    },

    {
        { itemId = xi.item.NONE,        weight = 957 }, -- nothing
        { itemId = xi.item.EURYTOS_BOW, weight =  43 }, -- eurytos_bow
    },

    {
        { itemId = xi.item.NONE,          weight = 582 }, -- nothing
        { itemId = xi.item.MYTHRIL_INGOT, weight = 302 }, -- mythril_ingot
        { itemId = xi.item.BLUE_CHIP,     weight =  19 }, -- blue_chip
        { itemId = xi.item.BLACK_CHIP,    weight =  38 }, -- black_chip
        { itemId = xi.item.PURPLE_CHIP,   weight =  10 }, -- purple_chip
        { itemId = xi.item.GREEN_CHIP,    weight =  19 }, -- green_chip
        { itemId = xi.item.MAHOGANY_LOG,  weight =  10 }, -- mahogany_log
        { itemId = xi.item.RED_ROCK,      weight =  10 }, -- red_rock
        { itemId = xi.item.BLACK_ROCK,    weight =  10 }, -- black_rock
    },

    {
        { itemId = xi.item.NONE,         weight = 887 }, -- nothing
        { itemId = xi.item.HI_POTION_P3, weight = 113 }, -- hi-potion_+3
    },
}

return content:register()
