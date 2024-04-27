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
