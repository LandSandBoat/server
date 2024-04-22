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
        { item = xi.item.FORSETIS_AXE,   weight = 250 }, -- forsetis_axe
        { item = xi.item.ARAMISS_RAPIER, weight = 250 }, -- aramiss_rapier
        { item = xi.item.SPARTAN_CESTI,  weight = 250 }, -- spartan_cesti
        { item = xi.item.DOMINION_MACE,  weight = 250 }, -- dominion_mace
    },

    {
        { item = xi.item.NONE,             weight = 250 }, -- nothing
        { item = xi.item.FUMA_KYAHAN,      weight = 100 }, -- fuma_kyahan
        { item = xi.item.PEACE_RING,       weight = 200 }, -- peace_ring
        { item = xi.item.ENHANCING_MANTLE, weight = 200 }, -- enhancing_mantle
        { item = xi.item.MASTER_BELT,      weight = 150 }, -- master_belt
        { item = xi.item.OCHIUDOS_KOTE,    weight = 100 }, -- ochiudos_kote
    },

    {
        { item = xi.item.NONE,           weight = 850 }, -- nothing
        { item = xi.item.HI_RERAISER,    weight = 100 }, -- hi-reraiser
        { item = xi.item.VILE_ELIXIR_P1, weight =  50 }, -- vile_elixir_+1
    },

    {
        { item = xi.item.PURPLE_ROCK,      weight = 166 }, -- purple_rock
        { item = xi.item.TRANSLUCENT_ROCK, weight = 166 }, -- translucent_rock
        { item = xi.item.RED_ROCK,         weight = 167 }, -- red_rock
        { item = xi.item.BLACK_ROCK,       weight = 167 }, -- black_rock
        { item = xi.item.YELLOW_ROCK,      weight = 167 }, -- yellow_rock
        { item = xi.item.WHITE_ROCK,       weight = 167 }, -- white_rock
    },

    {
        { item = xi.item.PAINITE,     weight = 125 }, -- painite
        { item = xi.item.AQUAMARINE,  weight = 125 }, -- aquamarine
        { item = xi.item.FLUORITE,    weight = 125 }, -- fluorite
        { item = xi.item.ZIRCON,      weight = 125 }, -- zircon
        { item = xi.item.SUNSTONE,    weight = 125 }, -- sunstone
        { item = xi.item.CHRYSOBERYL, weight = 125 }, -- chrysoberyl
        { item = xi.item.MOONSTONE,   weight = 125 }, -- moonstone
        { item = xi.item.JADEITE,     weight = 125 }, -- jadeite
    },

    {
        { item = xi.item.NONE,         weight = 517 }, -- nothing
        { item = xi.item.MAHOGANY_LOG, weight = 333 }, -- mahogany_log
        { item = xi.item.EBONY_LOG,    weight = 150 }, -- ebony_log
    },

    {
        { item = xi.item.STEEL_INGOT,     weight = 350 }, -- steel_ingot
        { item = xi.item.MYTHRIL_INGOT,   weight = 150 }, -- mythril_ingot
        { item = xi.item.DARKSTEEL_INGOT, weight = 150 }, -- darksteel_ingot
        { item = xi.item.GOLD_INGOT,      weight = 350 }, -- gold_ingot
    },
}

return content:register()
