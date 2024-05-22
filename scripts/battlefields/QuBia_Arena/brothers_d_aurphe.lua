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
        { item = xi.item.CREEK_M_CLOMPS,   weight = 125 }, -- creek_m_clomps
        { item = xi.item.CREEK_F_CLOMPS,   weight = 125 }, -- creek_f_clomps
        { item = xi.item.MARINE_M_BOOTS,   weight = 125 }, -- marine_m_boots
        { item = xi.item.MARINE_F_BOOTS,   weight = 125 }, -- marine_f_boots
        { item = xi.item.WOOD_M_LEDELSENS, weight = 125 }, -- wood_m_ledelsens
        { item = xi.item.WOOD_F_LEDELSENS, weight = 125 }, -- wood_f_ledelsens
        { item = xi.item.DUNE_SANDALS,     weight = 125 }, -- dune_sandals
        { item = xi.item.RIVER_GAITERS,    weight = 125 }, -- river_gaiters
    },

    {
        { item = xi.item.CROSS_COUNTERS, weight =  43 }, -- cross-counters
        { item = xi.item.CHRYSOBERYL,    weight =  10 }, -- chrysoberyl
        { item = xi.item.JADEITE,        weight =  94 }, -- jadeite
        { item = xi.item.SUNSTONE,       weight = 113 }, -- sunstone
        { item = xi.item.ZIRCON,         weight =  75 }, -- zircon
        { item = xi.item.CLEAR_CHIP,     weight =  10 }, -- clear_chip
        { item = xi.item.RED_CHIP,       weight =  38 }, -- red_chip
        { item = xi.item.YELLOW_CHIP,    weight =  38 }, -- yellow_chip
        { item = xi.item.GOLD_INGOT,     weight = 151 }, -- gold_ingot
        { item = xi.item.PURPLE_ROCK,    weight =  19 }, -- purple_rock
        { item = xi.item.WHITE_ROCK,     weight =  19 }, -- white_rock
    },

    {
        { item = xi.item.STEEL_INGOT,      weight = 132 }, -- steel_ingot
        { item = xi.item.TRANSLUCENT_ROCK, weight = 113 }, -- translucent_rock
        { item = xi.item.DARKSTEEL_INGOT,  weight = 113 }, -- darksteel_ingot
        { item = xi.item.PAINITE,          weight =  50 }, -- painite
        { item = xi.item.EBONY_LOG,        weight = 132 }, -- ebony_log
        { item = xi.item.WHITE_CHIP,       weight =  10 }, -- white_chip
        { item = xi.item.MOONSTONE,        weight = 151 }, -- moonstone
        { item = xi.item.ZIRCON,           weight =  75 }, -- zircon
        { item = xi.item.FLUORITE,         weight =  57 }, -- fluorite
        { item = xi.item.CHRYSOBERYL,      weight =  57 }, -- chrysoberyl
        { item = xi.item.GREEN_ROCK,       weight =  38 }, -- green_rock
        { item = xi.item.HI_RERAISER,      weight =  38 }, -- hi-reraiser
        { item = xi.item.VILE_ELIXIR_P1,   weight =  38 }, -- vile_elixir_+1
    },

    {
        { item = xi.item.SCROLL_OF_FLARE,           weight = 283 }, -- scroll_of_flare
        { item = xi.item.SCROLL_OF_VALOR_MINUET_IV, weight = 358 }, -- scroll_of_valor_minuet_iv
        { item = xi.item.SCROLL_OF_RERAISE_II,      weight = 264 }, -- scroll_of_reraise_ii
    },

    {
        { item = xi.item.NONE,        weight = 957 }, -- nothing
        { item = xi.item.EURYTOS_BOW, weight =  43 }, -- eurytos_bow
    },

    {
        { item = xi.item.NONE,          weight = 582 }, -- nothing
        { item = xi.item.MYTHRIL_INGOT, weight = 302 }, -- mythril_ingot
        { item = xi.item.BLUE_CHIP,     weight =  19 }, -- blue_chip
        { item = xi.item.BLACK_CHIP,    weight =  38 }, -- black_chip
        { item = xi.item.PURPLE_CHIP,   weight =  10 }, -- purple_chip
        { item = xi.item.GREEN_CHIP,    weight =  19 }, -- green_chip
        { item = xi.item.MAHOGANY_LOG,  weight =  10 }, -- mahogany_log
        { item = xi.item.RED_ROCK,      weight =  10 }, -- red_rock
        { item = xi.item.BLACK_ROCK,    weight =  10 }, -- black_rock
    },

    {
        { item = xi.item.NONE,         weight = 887 }, -- nothing
        { item = xi.item.HI_POTION_P3, weight = 113 }, -- hi-potion_+3
    },
}

return content:register()
