-----------------------------------
-- Area: Horlais Peak
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Tails of Woe
    [1] =
    {
        {
            { itemid = xi.item.BLITZ_RING, droprate = 150 }, -- blitz Ring
            { itemid = xi.item.NONE,       droprate = 850 }, -- Nothing
        },

        {
            { itemid = xi.item.AEGIS_RING,    droprate = 300 }, -- aegis Ring
            { itemid = xi.item.TUNDRA_MANTLE, droprate = 200 }, -- tundra mantle
            { itemid = xi.item.DRUIDS_ROPE,   droprate = 200 }, -- druids rope
            { itemid = xi.item.NONE,          droprate = 300 }, -- Nothing
        },

        {
            { itemid = xi.item.FIRE_SPIRIT_PACT,     droprate = 145 }, -- firespirit
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 165 }, -- erase
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate = 140 }, -- phalanx
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 123 }, -- absorb-str
            { itemid = xi.item.PERIDOT,              droprate =  94 }, -- peridot
            { itemid = xi.item.PEARL,                droprate =  94 }, -- pearl
            { itemid = xi.item.GREEN_ROCK,           droprate =  13 }, -- green rock
            { itemid = xi.item.AMETRINE,             droprate =  53 }, -- ametrine
            { itemid = xi.item.GOLD_BEASTCOIN,       droprate =  70 }, -- gold beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN,    droprate =  50 }, -- mythril beastcoin
            { itemid = xi.item.YELLOW_ROCK,          droprate =  53 }, -- yellow rock
            { itemid = xi.item.NONE,                 droprate =   0 }, -- nothing
        },

        {
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 125 }, -- erase
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate = 110 }, -- phalanx
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 104 }, -- absorb-str
            { itemid = xi.item.PERIDOT,              droprate =  94 }, -- peridot
            { itemid = xi.item.PEARL,                droprate =  94 }, -- pearl
            { itemid = xi.item.GREEN_ROCK,           droprate =  53 }, -- green rock
            { itemid = xi.item.AMETRINE,             droprate =  73 }, -- ametrine
            { itemid = xi.item.GOLD_BEASTCOIN,       droprate =  70 }, -- gold beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN,    droprate =  70 }, -- mythril beastcoin
            { itemid = xi.item.YELLOW_ROCK,          droprate =  73 }, -- yellow rock
            { itemid = xi.item.NONE,                 droprate =  94 }, -- nothing
        },

        {
            { itemid = xi.item.FIRE_SPIRIT_PACT,      droprate = 174 }, -- firespirit
            { itemid = xi.item.SCROLL_OF_ERASE,       droprate =  16 }, -- vile elixir
            { itemid = xi.item.SCROLL_OF_PHALANX,     droprate = 114 }, -- icespikes
            { itemid = xi.item.SCROLL_OF_ABSORB_STR,  droprate = 174 }, -- refresh
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 138 }, -- utsusemi ni
            { itemid = xi.item.GREEN_ROCK,            droprate =  18 }, -- green rock
            { itemid = xi.item.BLACK_ROCK,            droprate =  18 }, -- black rock
            { itemid = xi.item.BLUE_ROCK,             droprate =  17 }, -- blue rock
            { itemid = xi.item.RED_ROCK,              droprate =  16 }, -- red rock
            { itemid = xi.item.PURPLE_ROCK,           droprate =  16 }, -- purple rock
            { itemid = xi.item.WHITE_ROCK,            droprate =  16 }, -- white rock
            { itemid = xi.item.YELLOW_ROCK,           droprate =  17 }, -- yellow rock
            { itemid = xi.item.TRANSLUCENT_ROCK,      droprate =  17 }, -- translucent rock
            { itemid = xi.item.RERAISER,              droprate =  21 }, -- reraiser
            { itemid = xi.item.OAK_LOG,               droprate =  22 }, -- oak log
            { itemid = xi.item.ROSEWOOD_LOG,          droprate =  18 }, -- rosewood log
            { itemid = xi.item.GOLD_BEASTCOIN,        droprate = 120 }, -- gold beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN,     droprate = 102 }, -- mythril beastcoin
            { itemid = xi.item.PEARL,                 droprate =  21 }, -- pearl
            { itemid = xi.item.TURQUOISE,             droprate =  23 }, -- Turquoise
            { itemid = xi.item.GOSHENITE,             droprate =  19 }, -- Goshenite
            { itemid = xi.item.BLACK_PEARL,           droprate =  18 }, -- Black pearl
            { itemid = xi.item.SPHENE,                droprate =  17 }, -- sphene
            { itemid = xi.item.GARNET,                droprate =  20 }, -- garnet
            { itemid = xi.item.AMETRINE,              droprate =  18 }, -- ametrine
            { itemid = xi.item.NONE,                  droprate =   0 }, -- nothing
        },

        {
            { itemid = xi.item.SCROLL_OF_PHALANX,     droprate = 87 }, -- icespikes
            { itemid = xi.item.SCROLL_OF_ABSORB_STR,  droprate = 75 }, -- refresh
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 75 }, -- utsusemi ni
            { itemid = xi.item.OAK_LOG,               droprate = 80 }, -- oak log
            { itemid = xi.item.ROSEWOOD_LOG,          droprate = 97 }, -- rosewood log
            { itemid = xi.item.PEARL,                 droprate = 86 }, -- pearl
            { itemid = xi.item.TURQUOISE,             droprate = 88 }, -- Turquoise
            { itemid = xi.item.GOSHENITE,             droprate = 79 }, -- Goshenite
            { itemid = xi.item.BLACK_PEARL,           droprate = 93 }, -- Black pearl
            { itemid = xi.item.SPHENE,                droprate = 79 }, -- sphene
            { itemid = xi.item.GARNET,                droprate = 71 }, -- garnet
            { itemid = xi.item.AMETRINE,              droprate = 90 }, -- ametrine
            { itemid = xi.item.NONE,                  droprate =  0 }, -- nothing
        },
    },

    -- BCNM Shooting Fish
    [9] =
    {
        {
            { itemid = xi.item.MANNEQUIN_HEAD, droprate = 1000 }, -- mannequin_head
        },

        {
            { itemid = xi.item.SHALL_SHELL, droprate = 1000 }, -- shall_shell
        },

        {
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 300 }, -- mythril_beastcoin
            { itemid = xi.item.BLACK_ROCK,        droprate =  70 }, -- black_rock
            { itemid = xi.item.PURPLE_ROCK,       droprate =  30 }, -- purple_rock
            { itemid = xi.item.WHITE_ROCK,        droprate = 100 }, -- white_rock
            { itemid = xi.item.PLATOON_BOW,       droprate = 100 }, -- platoon_bow
            { itemid = xi.item.PLATOON_MACE,      droprate = 100 }, -- platoon_mace
            { itemid = xi.item.PLATOON_DISC,      droprate = 150 }, -- platoon_disc
            { itemid = xi.item.PLATOON_GUN,       droprate = 150 }, -- platoon_gun
        },

        {
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 310 }, -- mythril_beastcoin
            { itemid = xi.item.GREEN_ROCK,        droprate =  50 }, -- green_rock
            { itemid = xi.item.YELLOW_ROCK,       droprate =  40 }, -- yellow_rock
            { itemid = xi.item.BLUE_ROCK,         droprate =  40 }, -- blue_rock
            { itemid = xi.item.RED_ROCK,          droprate =  40 }, -- red_rock
            { itemid = xi.item.TRANSLUCENT_ROCK,  droprate = 110 }, -- translucent_rock
            { itemid = xi.item.PLATOON_CESTI,     droprate = 130 }, -- platoon_cesti
            { itemid = xi.item.PLATOON_CUTTER,    droprate = 100 }, -- platoon_cutter
            { itemid = xi.item.PLATOON_SPATHA,    droprate =  80 }, -- platoon_spatha
            { itemid = xi.item.PLATOON_ZAGHNAL,   droprate = 100 }, -- platoon_zaghnal
        },

        {
            { itemid = xi.item.NONE,                    droprate = 670 }, -- nothing
            { itemid = xi.item.HANDFUL_OF_PUGIL_SCALES, droprate = 190 }, -- handful_of_pugil_scales
            { itemid = xi.item.SHALL_SHELL,             droprate = 140 }, -- shall_shell
        },

        {
            { itemid = xi.item.NONE,           droprate = 930 }, -- nothing
            { itemid = xi.item.MANNEQUIN_BODY, droprate =  70 }, -- mannequin_body
        },

        {
            { itemid = xi.item.SCROLL_OF_BLAZE_SPIKES,  droprate = 180 }, -- scroll_of_blaze_spikes
            { itemid = xi.item.SCROLL_OF_HORDE_LULLABY, droprate = 510 }, -- scroll_of_horde_lullaby
            { itemid = xi.item.THUNDER_SPIRIT_PACT,     droprate = 280 }, -- thunder_spirit_pact
            { itemid = xi.item.SCROLL_OF_WARP,          droprate =  30 }, -- scroll_of_warp
        },
    },

    -- BCNM Under Observation
    [12] =
    {
        {
            { itemid = xi.item.NONE,          droprate = 910 }, -- Nothing
            { itemid = xi.item.PEACOCK_CHARM, droprate =  90 }, -- Peacock Charm
        },

        {
            { itemid = xi.item.NONE,          droprate = 467 }, -- Nothing
            { itemid = xi.item.BEHOURD_LANCE, droprate =  48 }, -- Behourd Lance
            { itemid = xi.item.MUTILATOR,     droprate =  61 }, -- Mutilator
            { itemid = xi.item.RAIFU,         droprate =  46 }, -- Raifu
            { itemid = xi.item.TILT_BELT,     droprate = 302 }, -- Tilt Belt
            { itemid = xi.item.TOURNEY_PATAS, droprate =  76 }, -- Tourney Patas
        },

        {
            { itemid = xi.item.NONE,                  droprate = 413 }, -- Nothing
            { itemid = xi.item.BUZZARD_TUCK,          droprate =  42 }, -- Buzzard Tuck
            { itemid = xi.item.DE_SAINTRES_AXE,       droprate =  77 }, -- De Saintres Axe
            { itemid = xi.item.GRUDGE_SWORD,          droprate =  73 }, -- Grudge Sword
            { itemid = xi.item.MANTRA_BELT,           droprate = 258 }, -- Mantra Belt
            { itemid = xi.item.SCROLL_OF_REFRESH,     droprate =  68 }, -- Scroll Of Refresh
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate =  55 }, -- Scroll Of Utsusemi Ni
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,  droprate =  14 }, -- Scroll Of Ice Spikes
        },

        {
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,  droprate = 114 }, -- Scroll Of Ice Spikes
            { itemid = xi.item.SCROLL_OF_REFRESH,     droprate = 174 }, -- Scroll Of Refresh
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 138 }, -- Scroll Of Utsusemi Ni
            { itemid = xi.item.RED_ROCK,              droprate =  16 }, -- Red Rock
            { itemid = xi.item.BLUE_ROCK,             droprate =  17 }, -- Blue Rock
            { itemid = xi.item.YELLOW_ROCK,           droprate =  17 }, -- Yellow Rock
            { itemid = xi.item.GREEN_ROCK,            droprate =  18 }, -- Green Rock
            { itemid = xi.item.TRANSLUCENT_ROCK,      droprate =  17 }, -- Translucent Rock
            { itemid = xi.item.PURPLE_ROCK,           droprate =  16 }, -- Purple Rock
            { itemid = xi.item.BLACK_ROCK,            droprate =  18 }, -- Black Rock
            { itemid = xi.item.WHITE_ROCK,            droprate =  16 }, -- White Rock
            { itemid = xi.item.MYTHRIL_BEASTCOIN,     droprate = 102 }, -- Mythril Beastcoin
            { itemid = xi.item.GOLD_BEASTCOIN,        droprate = 120 }, -- Gold Beastcoin
            { itemid = xi.item.OAK_LOG,               droprate =  22 }, -- Oak Log
            { itemid = xi.item.AMETRINE,              droprate =  18 }, -- Ametrine
            { itemid = xi.item.BLACK_PEARL,           droprate =  18 }, -- Black Pearl
            { itemid = xi.item.GARNET,                droprate =  20 }, -- Garnet
            { itemid = xi.item.GOSHENITE,             droprate =  19 }, -- Goshenite
            { itemid = xi.item.PEARL,                 droprate =  21 }, -- Pearl
            { itemid = xi.item.PERIDOT,               droprate =  35 }, -- Peridot
            { itemid = xi.item.SPHENE,                droprate =  17 }, -- Sphene
            { itemid = xi.item.TURQUOISE,             droprate =  23 }, -- Turquoise
            { itemid = xi.item.RERAISER,              droprate =  21 }, -- Reraiser
            { itemid = xi.item.VILE_ELIXIR,           droprate =  16 }, -- Vile Elixir
        },

        {
            { itemid = xi.item.FIRE_SPIRIT_PACT,     droprate = 116 }, -- Fire Spirit Pact
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 113 }, -- Scroll Of Absorb-str
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 137 }, -- Scroll Of Erase
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES, droprate =  67 }, -- Scroll Of Ice Spikes
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate =  99 }, -- Scroll Of Phalanx
            { itemid = xi.item.AMETRINE,             droprate =  58 }, -- Ametrine
            { itemid = xi.item.BLACK_PEARL,          droprate =  52 }, -- Black Pearl
            { itemid = xi.item.GARNET,               droprate =  51 }, -- Garnet
            { itemid = xi.item.GOSHENITE,            droprate =  65 }, -- Goshenite
            { itemid = xi.item.PEARL,                droprate =  61 }, -- Pearl
            { itemid = xi.item.PERIDOT,              droprate =  63 }, -- Peridot
            { itemid = xi.item.SPHENE,               droprate =  55 }, -- Sphene
            { itemid = xi.item.TURQUOISE,            droprate =  62 }, -- Turquoise
        },

        {
            { itemid = xi.item.HECTEYES_EYE, droprate = 1000 }, -- Hecteyes Eye
        },

        {
            { itemid = xi.item.VIAL_OF_MERCURY, droprate = 1000 }, -- Vial Of Mercury
        },
    },

    -- BCNM Shots in the Dark
    [14] =
    {
        {
            { itemid = xi.item.GOLD_BEASTCOIN,    droprate = 500 }, -- gold_beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 500 }, -- mythril_beastcoin
        },

        {
            { itemid = xi.item.STEEL_INGOT, droprate = 500 }, -- steel_ingot
            { itemid = xi.item.AQUAMARINE,  droprate = 500 }, -- aquamarine
        },

        {
            { itemid = xi.item.NONE,         droprate = 500 }, -- nothing
            { itemid = xi.item.DEMON_QUIVER, droprate = 500 }, -- demon_quiver
        },

        {
            { itemid = xi.item.NONE,                droprate = 600 }, -- nothing
            { itemid = xi.item.TELEPORT_RING_HOLLA, droprate = 200 }, -- teleport_ring_holla
            { itemid = xi.item.TELEPORT_RING_VAHZL, droprate = 200 }, -- teleport_ring_vahzl
        },

        {
            { itemid = xi.item.NONE,                droprate = 600 }, -- nothing
            { itemid = xi.item.SAPIENT_CAPE,        droprate = 200 }, -- sapient_cape
            { itemid = xi.item.TRAINERS_WRISTBANDS, droprate = 200 }, -- trainers_wristbands
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
