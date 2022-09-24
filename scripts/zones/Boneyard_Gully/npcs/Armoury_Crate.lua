-----------------------------------
-- Area: Boneyard Gully
--  NPC: Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

local loot =
{
    -- ENM: Like the Wind
    [673] =
    {
        {
            { itemid =    0, droprate = 140 }, -- nothing
            { itemid = 1763, droprate = 310 }, -- Viridian Urushi
            { itemid = 1769, droprate = 241 }, -- Square of Galateia
            { itemid = 1764, droprate = 310 }, -- Kejusu Satin
        },

        {
            { itemid =    0, droprate = 862 }, -- nothing
            { itemid = 1842, droprate = 138 }, -- Cloud Evoker
        },

        {
            { itemid =     0, droprate = 380 }, -- nothing
            { itemid = 17946, droprate = 138 }, -- Maneater
            { itemid = 18358, droprate = 172 }, -- Wagh Baghnakhs
            { itemid = 16976, droprate = 138 }, -- Onimaru
            { itemid =  4990, droprate = 172 }, -- Army's Paeon V
        },

        {
            { itemid =     0, droprate = 380 }, -- nothing
            { itemid = 17946, droprate = 138 }, -- Maneater
            { itemid = 18358, droprate = 172 }, -- Wagh Baghnakhs
            { itemid = 16976, droprate = 138 }, -- Onimaru
            { itemid =  4990, droprate = 172 }, -- Army's Paeon V
        },
    },

    -- ENM: Sheep in Antlion's Clothing
    [674] =
    {
        {
            {itemid =    0, droprate = 124}, -- Nothing
            {itemid = 1769, droprate = 268}, -- Square of Galateia (26.8% Drop Rate)
            {itemid = 1764, droprate = 266}, -- Kejusu Satin
            {itemid = 1763, droprate = 342}, -- Viridian Urushi
        },

        {
            {itemid =    0, droprate = 944}, -- Nothing
            {itemid = 1842, droprate =  56}, -- Cloud Evoker (5.6% Drop Rate)
        },

        {
            {itemid = 17829, droprate =  82}, -- Hagun
            {itemid = 17945, droprate =  92}, -- Martial Axe
            {itemid = 17467, droprate =  63}, -- Martial Wand
            {itemid = 13690, droprate = 105}, -- Forager's Mantle
            {itemid = 13109, droprate = 121}, -- Harmonia's Torque
        },
    },

    -- ENM: Shell We Dance?
    [675] =
    {
        {
            {itemid =    0, droprate = 250}, -- Nothing
            {itemid = 1762, droprate = 350}, -- Cassia Lumber
            {itemid = 1767, droprate = 325}, -- Eltoro Leather
            {itemid = 1771, droprate = 250}, -- Dragon Bone
        },

        {
            {itemid =    0, droprate = 812}, -- Nothing
            {itemid = 1842, droprate = 188}, -- Cloud Evoker
        },

        {
            {itemid =     0, droprate = 200}, -- Nothing
            {itemid = 18099, droprate = 150}, -- Stone-splitter
            {itemid = 17365, droprate = 175}, -- Frenzy Fife
            {itemid = 18015, droprate = 238}, -- Blau Dolch
            {itemid =  4990, droprate = 237},  -- Scroll of Army's Paeon V
        },

        {
            {itemid =     0, droprate = 200}, -- Nothing
            {itemid = 18099, droprate = 150}, -- Stone-splitter
            {itemid = 17365, droprate = 175}, -- Frenzy Fife
            {itemid = 18015, droprate = 238}, -- Blau Dolch
            {itemid =  4990, droprate = 237},  -- Scroll of Army's Paeon V
        },
    },

    -- ENM: Totentanz (Wiki did not have groupings or droprates, these values are guesses based on other ENMs)
    [676] =
    {
        {
            {itemid =    0, droprate = 800}, -- Nothing
            {itemid = 1842, droprate = 200}, -- Cloud Evoker
        },
        {
            {itemid =     0, droprate = 325}, -- Nothing
            {itemid = 16976, droprate = 100}, -- Onimaru
            {itemid = 18015, droprate = 250}, -- Blau Dolch
            {itemid = 18099, droprate = 150}, -- Stone-splitter
            {itemid = 17365, droprate = 175}, -- Frenzy Fife
        },
        {
            {itemid =     0, droprate = 670}, -- Nothing
            {itemid = 17946, droprate = 100}, -- Maneater
            {itemid = 18358, droprate =  65}, -- Wagh Baghnakhs
            {itemid = 17469, droprate =  65}, -- Raise II Rod
            {itemid = 15464, droprate = 100}, -- Corse Cape
        },
        {
            {itemid =    0, droprate = 325}, -- Nothing
            {itemid = 1763, droprate = 350}, -- Viridian Urushi
            {itemid = 1767, droprate = 325}, -- Eltoro Leather
        },
        {
            {itemid =    0, droprate = 150}, -- Nothing
            {itemid = 1841, droprate = 225}, -- Unicorn Horn
            {itemid = 1762, droprate = 375}, -- Cassia Lumber
            {itemid = 1771, droprate = 250}, -- Dragon Bone
        },
    },

    -- Requiem of Sin
    [678] =
    {
        {
            {itemid =    0, droprate = 655}, -- Nothing
            {itemid = 1762, droprate = 150}, -- Cassia Lumber
            {itemid = 1767, droprate = 120}, -- Eltoro Leather
            {itemid = 1771, droprate =  75}, -- Dragon Bone
        },
        {
            {itemid =    0, droprate = 655}, -- Nothing
            {itemid = 1762, droprate = 150}, -- Cassia Lumber
            {itemid = 1767, droprate = 120}, -- Eltoro Leather
            {itemid = 1771, droprate =  75}, -- Dragon Bone
        },
        {
            {itemid =    0, droprate = 650}, -- Nothing
            {itemid = 1763, droprate = 110}, -- Viridian Urushi
            {itemid = 1764, droprate = 120}, -- Kejusu Satin
            {itemid = 1769, droprate = 110}, -- Galateia
        },
        {
            {itemid =    0, droprate = 650}, -- Nothing
            {itemid = 1763, droprate = 110}, -- Viridian Urushi
            {itemid = 1764, droprate = 120}, -- Kejusu Satin
            {itemid = 1769, droprate = 110}, -- Galateia
        },
        {
            {itemid =    0, droprate = 745}, -- Nothing
            {itemid = 18019, droprate = 75}, -- X's Knife
            {itemid = 18057, droprate = 90}, -- Y's Scythe
            {itemid = 18101, droprate = 90}, -- Z's Trident
        },
        {
            {itemid =    0, droprate = 835}, -- Nothing
            {itemid =  844, droprate = 110}, -- Phoenix Feather
            {itemid =  942, droprate =  45}, -- Philosopher's Stone
            {itemid = 1446, droprate =  10}, -- Lacquer Tree Log
        },
        {
            {itemid =    0, droprate = 805}, -- Nothing
            {itemid =  703, droprate =  50}, -- Petrified Log
            {itemid =  722, droprate =  10}, -- Divine Log
            {itemid =  831, droprate =  10}, -- Shining Cloth
            {itemid = 1132, droprate =  75}, -- Raxa
            {itemid = 1465, droprate =  50}, -- Granite
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
