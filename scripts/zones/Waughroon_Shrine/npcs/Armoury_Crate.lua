-----------------------------------
-- Area: Waughroon Shrine
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM The Worm's Turn
    [65] =
    {
        {
            { itemid = xi.item.NONE,                  droprate = 125 }, -- nothing
            { itemid = xi.item.FIRE_SPIRIT_PACT,      droprate = 125 }, -- fire_spirit_pact
            { itemid = xi.item.SCROLL_OF_PHALANX,     droprate = 125 }, -- scroll_of_phalanx
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = xi.item.SCROLL_OF_ERASE,       droprate = 125 }, -- scroll_of_erase
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,  droprate = 125 }, -- scroll_of_ice_spikes
            { itemid = xi.item.SCROLL_OF_ABSORB_STR,  droprate = 125 }, -- scroll_of_absorb-str
            { itemid = xi.item.SCROLL_OF_REFRESH,     droprate = 125 }, -- scroll_of_refresh
        },

        {
            { itemid = xi.item.NONE,              droprate = 125 }, -- nothing
            { itemid = xi.item.ENHANCING_EARRING, droprate = 125 }, -- enhancing_earring
            { itemid = xi.item.SPIRIT_TORQUE,     droprate = 125 }, -- spirit_torque
            { itemid = xi.item.GUARDING_GORGET,   droprate = 125 }, -- guarding_gorget
            { itemid = xi.item.NEMESIS_EARRING,   droprate = 125 }, -- nemesis_earring
            { itemid = xi.item.EARTH_MANTLE,      droprate = 125 }, -- earth_mantle
            { itemid = xi.item.STRIKE_SHIELD,     droprate = 125 }, -- strike_shield
            { itemid = xi.item.SHIKAR_BOW,        droprate = 125 }, -- shikar_bow
        },

        {
            { itemid = xi.item.OAK_LOG,      droprate = 500 }, -- oak_log
            { itemid = xi.item.ROSEWOOD_LOG, droprate = 500 }, -- rosewood_log
        },

        {
            { itemid = xi.item.GOLD_BEASTCOIN,    droprate = 500 }, -- gold_beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 500 }, -- mythril_beastcoin
        },

        {
            { itemid = xi.item.BLACK_PEARL, droprate = 200 }, -- black_pearl
            { itemid = xi.item.AMETRINE,    droprate = 200 }, -- ametrine
            { itemid = xi.item.YELLOW_ROCK, droprate = 200 }, -- yellow_rock
            { itemid = xi.item.PERIDOT,     droprate = 200 }, -- peridot
            { itemid = xi.item.TURQUOISE,   droprate = 200 }, -- turquoise
        },

        {
            { itemid = xi.item.NONE,     droprate = 800 }, -- nothing
            { itemid = xi.item.RERAISER, droprate = 200 }, -- reraiser
        },
    },

    -- BCNM 3, 2, 1...
    [69] =
    {
        {
            { itemid = xi.item.KAGEBOSHI, droprate = 500 }, -- kageboshi
            { itemid = xi.item.ODENTA,    droprate = 500 }, -- odenta
        },

        {
            { itemid = xi.item.OCEAN_BELT,  droprate = 200 }, -- ocean_belt
            { itemid = xi.item.FOREST_BELT, droprate = 200 }, -- forest_belt
            { itemid = xi.item.STEPPE_BELT, droprate = 200 }, -- steppe_belt
            { itemid = xi.item.JUNGLE_BELT, droprate = 200 }, -- jungle_belt
            { itemid = xi.item.DESERT_BELT, droprate = 200 }, -- desert_belt
        },

        {
            { itemid = xi.item.NONE,                droprate = 250 }, -- nothing
            { itemid = xi.item.SCROLL_OF_FREEZE,    droprate = 125 }, -- scroll_of_freeze
            { itemid = xi.item.SCROLL_OF_QUAKE,     droprate = 125 }, -- scroll_of_quake
            { itemid = xi.item.SCROLL_OF_RAISE_II,  droprate = 125 }, -- scroll_of_raise_ii
            { itemid = xi.item.SCROLL_OF_REGEN_III, droprate = 125 }, -- scroll_of_regen_iii
            { itemid = xi.item.FIRE_SPIRIT_PACT,    droprate = 125 }, -- fire_spirit_pact
            { itemid = xi.item.LIGHT_SPIRIT_PACT,   droprate = 125 }, -- light_spirit_pact
        },

        {
            { itemid = xi.item.NONE,          droprate = 800 }, -- nothing
            { itemid = xi.item.PETRIFIED_LOG, droprate = 200 }, -- petrified_log
        },
    },

    -- BCNM Royal Jelly
    [77] =
    {
        {
            { itemid = xi.item.VIAL_OF_SLIME_OIL, droprate = 1000 },
        },
        {
            { itemid = xi.item.VIAL_OF_SLIME_OIL, droprate = 1000 },
        },
        {
            { itemid = xi.item.ARCHERS_RING, droprate =  91 },
        },
        {
            { itemid = xi.item.MANA_RING,             droprate = 469 },
            { itemid = xi.item.GRUDGE_SWORD,          droprate = 152 },
            { itemid = xi.item.DE_SAINTRES_AXE,       droprate = 120 },
            { itemid = xi.item.BUZZARD_TUCK,          droprate = 118 },
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 106 },
        },
        {
            { itemid = xi.item.MARKSMANS_RING, droprate = 258 },
            { itemid = xi.item.DUSKY_STAFF,    droprate = 152 },
            { itemid = xi.item.HIMMEL_STOCK,   droprate = 101 },
            { itemid = xi.item.SEALED_MACE,    droprate  = 98 },
            { itemid = xi.item.SHIKAR_BOW,     droprate  = 98 },
        },
        {
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 123 },
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 165 },
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate = 140 },
            { itemid = xi.item.FIRE_SPIRIT_PACT,     droprate = 145 },
            { itemid = xi.item.STEEL_SHEET,          droprate = 229 },
            { itemid = xi.item.STEEL_INGOT,          droprate = 238 },
        },
        {
            { itemid = xi.item.SCROLL_OF_REFRESH,     droprate = 263 },
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,  droprate = 246 },
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 177 },
            { itemid = xi.item.GOLD_BEASTCOIN,        droprate = 182 },
            { itemid = xi.item.MYTHRIL_BEASTCOIN,     droprate = 133 },
            { itemid = xi.item.PERIDOT,               droprate =  27 },
            { itemid = xi.item.TURQUOISE,             droprate =  20 },
            { itemid = xi.item.BLACK_PEARL,           droprate =  15 },
            { itemid = xi.item.GOSHENITE,             droprate =  15 },
            { itemid = xi.item.SPHENE,                droprate =  15 },
            { itemid = xi.item.AMETRINE,              droprate =  10 },
            { itemid = xi.item.GARNET,                droprate =   7 },
            { itemid = xi.item.BLACK_ROCK,            droprate =  12 },
            { itemid = xi.item.GREEN_ROCK,            droprate =   7 },
            { itemid = xi.item.WHITE_ROCK,            droprate =   7 },
            { itemid = xi.item.BLUE_ROCK,             droprate =   2 },
            { itemid = xi.item.TRANSLUCENT_ROCK,      droprate =   2 },
            { itemid = xi.item.OAK_LOG,               droprate =   5 },
            { itemid = xi.item.ROSEWOOD_LOG,          droprate =   5 },
            { itemid = xi.item.VILE_ELIXIR,           droprate =  10 },
            { itemid = xi.item.RERAISER,              droprate =   2 },
        },
    },

    -- BCNM Up In Arms
    [79] =
    {
        {
            { itemid = xi.item.GIL, droprate = 1000, amount = 15000 }, -- Gil
        },

        {
            { itemid = xi.item.BLACK_PEARL, droprate = 1000 }, -- Black Pearl
        },

        {
            { itemid = xi.item.PEARL, droprate = 1000 }, -- Pearl
        },

        {
            { itemid = xi.item.PEARL, droprate = 1000 }, -- Pearl
        },

        {
            { itemid = xi.item.PIECE_OF_OXBLOOD, droprate = 1000 }, -- Piece Of Oxblood
        },

        {
            { itemid = xi.item.PIECE_OF_OXBLOOD, droprate = 1000 }, -- Piece Of Oxblood
        },

        {
            { itemid = xi.item.PIECE_OF_OXBLOOD, droprate = 1000 }, -- Piece Of Oxblood
        },

        {
            { itemid = xi.item.TELEPORT_RING_ALTEP, droprate = 447 }, -- Teleport Ring Altep
            { itemid = xi.item.TELEPORT_RING_DEM,   droprate = 487 }, -- Teleport Ring Dem
        },

        {
            { itemid = xi.item.AJARI_BEAD_NECKLACE, droprate = 494 }, -- Ajari Bead Necklace
            { itemid = xi.item.PHILOMATH_STOLE,     droprate = 449 }, -- Philomath Stole
        },

        {
            { itemid = xi.item.AQUAMARINE,       droprate =  51 }, -- Aquamarine
            { itemid = xi.item.CHRYSOBERYL,      droprate =  32 }, -- Chrysoberyl
            { itemid = xi.item.DARKSTEEL_INGOT,  droprate =  39 }, -- Darksteel Ingot
            { itemid = xi.item.EBONY_LOG,        droprate =  21 }, -- Ebony Log
            { itemid = xi.item.HI_RERAISER,      droprate =  32 }, -- Hi-reraiser
            { itemid = xi.item.GOLD_INGOT,       droprate =  55 }, -- Gold Ingot
            { itemid = xi.item.JADEITE,          droprate =  62 }, -- Jadeite
            { itemid = xi.item.MYTHRIL_INGOT,    droprate =  81 }, -- Mythril Ingot
            { itemid = xi.item.MOONSTONE,        droprate =  56 }, -- Moonstone
            { itemid = xi.item.PAINITE,          droprate = 195 }, -- Painite
            { itemid = xi.item.STEEL_INGOT,      droprate =  58 }, -- Steel Ingot
            { itemid = xi.item.SUNSTONE,         droprate =  38 }, -- Sunstone
            { itemid = xi.item.TRANSLUCENT_ROCK, droprate =  11 }, -- Translucent Rock
            { itemid = xi.item.VILE_ELIXIR_P1,   droprate =  21 }, -- Vile Elixir +1
            { itemid = xi.item.YELLOW_ROCK,      droprate =  15 }, -- Yellow Rock
            { itemid = xi.item.ZIRCON,           droprate =  26 }, -- Zircon
            { itemid = xi.item.RED_ROCK,         droprate =  21 }, -- Red Rock
            { itemid = xi.item.MAHOGANY_LOG,     droprate =  17 }, -- Mahogany Log
            { itemid = xi.item.BLUE_ROCK,        droprate =   9 }, -- Blue Rock
            { itemid = xi.item.FLUORITE,         droprate =  62 }, -- Fluorite
            { itemid = xi.item.PURPLE_ROCK,      droprate =  11 }, -- Purple Rock
            { itemid = xi.item.BLACK_ROCK,       droprate =  11 }, -- Black Rock
            { itemid = xi.item.GREEN_ROCK,       droprate =  11 }, -- Green Rock
            { itemid = xi.item.WHITE_ROCK,       droprate =   9 }, -- White Rock
        },

        {
            { itemid = xi.item.NONE,         droprate =  932 }, -- Nothing
            { itemid = xi.item.KRAKEN_CLUB,  droprate =   13 }, -- Kraken Club
            { itemid = xi.item.WALKURE_MASK, droprate =   55 }, -- Walkure Mask
        },
    },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local battlefield = player:getBattlefield()
    if battlefield then
        xi.battlefield.HandleLootRolls(battlefield, loot[battlefield:getID()], nil, npc)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
