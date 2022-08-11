-----------------------------------
-- Area: Waughroon Shrine
--  NPC: Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

local loot =
{
    -- ENM: Fire in the Sky
    [962] =
    {
        {
            {itemid =    0, droprate = 950}, -- Nothing
            {itemid = 1842, droprate =  50}, -- Cloud Evoker
        },
        {
            {itemid =     0, droprate = 500}, -- Nothing
            {itemid = 17215, droprate = 250}, -- Thug's Zamburak
            {itemid = 16708, droprate = 250}, -- Horror Voulge
        },
        {
            {itemid =     0, droprate = 350}, -- Nothing
            {itemid = 13550, droprate = 200}, -- Crossbowman's Ring
            {itemid = 14675, droprate = 150}, -- Woodsman Ring
            {itemid = 13549, droprate = 300}, -- Ether Ring
        },
    },

    -- ENM: Bad Seed
    [963] =
    {
        {
            {itemid =    0, droprate = 950}, -- Nothing
            {itemid = 1842, droprate =  50}, -- Cloud Evoker
        },
        {
            {itemid =     0, droprate = 500}, -- Nothing
            {itemid = 15433, droprate = 250}, -- Reverend Sash
            {itemid = 15434, droprate = 250}, -- Vanguard Belt
        },
        {
            {itemid =     0, droprate = 350}, -- Nothing
            {itemid = 13550, droprate = 200}, -- Crossbowman's Ring
            {itemid = 14675, droprate = 150}, -- Woodsman Ring
            {itemid = 13549, droprate = 300}, -- Ether Ring
        },
    },

    -- ENM: Bugard in the Clouds
    [964] =
    {
        {
            {itemid = 678, droprate = 1000}, -- Aluminum Ore
        },
        {
            {itemid = 678, droprate = 1000}, -- Aluminum Ore
        },
        {
            {itemid =    0, droprate = 950}, -- Nothing
            {itemid = 1842, droprate =  50}, -- Cloud Evoker
        },
        {
            {itemid =     0, droprate = 700}, -- Nothing
            {itemid = 17133, droprate = 100}, -- Chanter's Staff
            {itemid = 16965, droprate = 100}, -- Koryukagemitsu
            {itemid = 18411, droprate = 100}, -- Buboso
        },
        {
            {itemid =     0, droprate = 600}, -- Nothing
            {itemid = 14682, droprate = 100}, -- Kshama Ring No. 2
            {itemid = 14683, droprate = 100}, -- Kshama Ring No. 4
            {itemid = 14685, droprate = 100}, -- Kshama Ring No. 5
            {itemid = 14686, droprate = 100}, -- Kshama Ring No. 9
        },
    },
    -- ENM: Beloved of the Atlantes
    [965] =
    {
        {
            {itemid = 678, droprate = 1000}, -- Aluminum Ore
        },
        {
            {itemid = 678, droprate = 1000}, -- Aluminum Ore
        },
        {
            {itemid = 678, droprate = 1000} ,-- Aluminum Ore
        },
        {
            {itemid = 678, droprate = 1000}, -- Aluminum Ore
        },
        {
            {itemid =    0, droprate = 950}, -- Nothing
            {itemid = 1842, droprate =  50}, -- Cloud Evoker
        },
        {
            {itemid =     0, droprate = 600}, -- Nothing
            {itemid = 17133, droprate = 100}, -- Chanter's Staff
            {itemid = 16965, droprate = 100}, -- Koryukagemitsu
            {itemid = 18411, droprate = 100}, -- Buboso
            {itemid = 18411, droprate = 100}, -- Raise Rod
        },
        {
            {itemid =     0, droprate = 600}, -- Nothing
            {itemid = 14682, droprate = 100}, -- Kshama Ring No. 2
            {itemid = 14684, droprate = 100}, -- Kshama Ring No. 3
            {itemid = 14683, droprate = 100}, -- Kshama Ring No. 4
            {itemid = 14685, droprate = 100}, -- Kshama Ring No. 5
            {itemid = 14687, droprate = 100}, -- Kshama Ring No. 6
            {itemid = 13551, droprate = 100}, -- Kshama Ring No. 8
            {itemid = 14686, droprate = 100}, -- Kshama Ring No. 9
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
