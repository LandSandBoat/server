-----------------------------------
-- Area: Boneyard Gully
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- ENM: Like the Wind
    [673] =
    {
        {
            { itemid = xi.item.NONE,                   droprate = 140 }, -- nothing
            { itemid = xi.item.POT_OF_VIRIDIAN_URUSHI, droprate = 310 }, -- Viridian Urushi
            { itemid = xi.item.SQUARE_OF_GALATEIA,     droprate = 241 }, -- Square of Galateia
            { itemid = xi.item.SQUARE_OF_KEJUSU_SATIN, droprate = 310 }, -- Kejusu Satin
        },

        {
            { itemid = xi.item.NONE,         droprate = 862 }, -- nothing
            { itemid = xi.item.CLOUD_EVOKER, droprate = 138 }, -- Cloud Evoker
        },

        {
            { itemid = xi.item.NONE,                    droprate = 380 }, -- nothing
            { itemid = xi.item.MANEATER,                droprate = 138 }, -- Maneater
            { itemid = xi.item.WAGH_BAGHNAKHS,          droprate = 172 }, -- Wagh Baghnakhs
            { itemid = xi.item.ONIMARU,                 droprate = 138 }, -- Onimaru
            { itemid = xi.item.SCROLL_OF_ARMYS_PAEON_V, droprate = 172 }, -- Army's Paeon V
        },

        {
            { itemid = xi.item.NONE,                    droprate = 380 }, -- nothing
            { itemid = xi.item.MANEATER,                droprate = 138 }, -- Maneater
            { itemid = xi.item.WAGH_BAGHNAKHS,          droprate = 172 }, -- Wagh Baghnakhs
            { itemid = xi.item.ONIMARU,                 droprate = 138 }, -- Onimaru
            { itemid = xi.item.SCROLL_OF_ARMYS_PAEON_V, droprate = 172 }, -- Army's Paeon V
        },
    },

    -- ENM: Sheep in Antlion's Clothing
    [674] =
    {
        {
            { itemid = xi.item.SQUARE_OF_GALATEIA,     droprate = 268 },  -- Square of Galateia (26.8% Drop Rate)
            { itemid = xi.item.SQUARE_OF_KEJUSU_SATIN, droprate = 266 },  -- Kejusu Satin
            { itemid = xi.item.POT_OF_VIRIDIAN_URUSHI, droprate = 342 },  -- Viridian Urushi
        },

        {
            { itemid = xi.item.NONE,         droprate = 944 }, -- nothing
            { itemid = xi.item.CLOUD_EVOKER, droprate =  56 }, -- Cloud Evoker
        },

        {
            { itemid = xi.item.HAGUN,            droprate =  82 }, -- Hagun
            { itemid = xi.item.MARTIAL_AXE,      droprate =  92 }, -- Martial Axe
            { itemid = xi.item.MARTIAL_WAND,     droprate =  63 }, -- Martial Wand
            { itemid = xi.item.FORAGERS_MANTLE,  droprate = 105 }, -- Forager's Mantle
            { itemid = xi.item.HARMONIAS_TORQUE, droprate = 121 }, -- Harmonia's Torque
        },
    },

    -- ENM: Shell We Dance?
    [675] =
    {
        {
            { itemid = xi.item.PIECE_OF_CASSIA_LUMBER,   droprate = 375 },  -- Cassia Lumber
            { itemid = xi.item.SQUARE_OF_ELTORO_LEATHER, droprate = 328 },  -- Eltoro Leather
            { itemid = xi.item.DRAGON_BONE,              droprate = 263 },  -- Dragon Bone
        },

        {
            { itemid = xi.item.NONE,         droprate = 812 }, -- nothing
            { itemid = xi.item.CLOUD_EVOKER, droprate = 188 }, -- Cloud Evoker
        },

        {
            { itemid = xi.item.STONE_SPLITTER,          droprate = 150 }, -- Stone-splitter
            { itemid = xi.item.FRENZY_FIFE,             droprate = 175 }, -- Frenzy Fife
            { itemid = xi.item.BLAU_DOLCH,              droprate = 238 }, -- Blau Dolch
            { itemid = xi.item.SCROLL_OF_ARMYS_PAEON_V, droprate = 238 }, -- Scroll of Army's Paeon V
        },

        {
            { itemid = xi.item.STONE_SPLITTER,          droprate = 150 }, -- Stone-splitter
            { itemid = xi.item.FRENZY_FIFE,             droprate = 175 }, -- Frenzy Fife
            { itemid = xi.item.BLAU_DOLCH,              droprate = 238 }, -- Blau Dolch
            { itemid = xi.item.SCROLL_OF_ARMYS_PAEON_V, droprate = 238 }, -- Scroll of Army's Paeon V
        },
    },

    -- ENM: Totentanz (Wiki did not have groupings or droprates, these values are guesses based on other ENMs)
    [676] =
    {
        {
            { itemid = xi.item.ONIMARU,                  droprate =  82 }, -- Onimaru
            { itemid = xi.item.BLAU_DOLCH,               droprate = 238 }, -- Blau Dolch
            { itemid = xi.item.STONE_SPLITTER,           droprate = 150 }, -- Stone-splitter
            { itemid = xi.item.MANEATER,                 droprate =  92 }, -- Maneater
            { itemid = xi.item.WAGH_BAGHNAKHS,           droprate =  63 }, -- Wagh Baghnakhs
            { itemid = xi.item.RAISE_II_ROD,             droprate =  65 }, -- Raise II Rod
            { itemid = xi.item.FRENZY_FIFE,              droprate = 175 }, -- Frenzy Fife
            { itemid = xi.item.CORSE_CAPE,               droprate =  83 }, -- Corse Cape
            { itemid = xi.item.CLOUD_EVOKER,             droprate = 188 }, -- Cloud Evoker
            { itemid = xi.item.POT_OF_VIRIDIAN_URUSHI,   droprate = 342 }, -- Viridian Urushi
            { itemid = xi.item.SQUARE_OF_ELTORO_LEATHER, droprate = 328 }, -- Eltoro Leather
            { itemid = xi.item.UNICORN_HORN,             droprate = 238 }, -- Unicorn Horn
            { itemid = xi.item.PIECE_OF_CASSIA_LUMBER,   droprate = 375 }, -- Cassia Lumber
            { itemid = xi.item.DRAGON_BONE,              droprate = 263 }, -- Dragon Bone
        },
    }
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
