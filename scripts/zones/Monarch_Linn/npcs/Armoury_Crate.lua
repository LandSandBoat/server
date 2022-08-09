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
