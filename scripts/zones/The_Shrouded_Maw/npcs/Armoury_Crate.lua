-----------------------------------
-- Area: The Shrouded Maw
--  NPC: Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
-----------------------------------
local entity = {}

local loot =
{
    -- Test your Mite
    [705] =
    {
        {
            {itemid =    0, droprate = 950}, -- Nothing
            {itemid = 1842, droprate =  50}, -- Cloud Evoker
        },
        {
            {itemid =     0, droprate = 750}, -- Nothing
            {itemid = 14766, droprate = 250}, -- Geist Earring
            {itemid = 15432, droprate = 250}, -- Quick Belt
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
