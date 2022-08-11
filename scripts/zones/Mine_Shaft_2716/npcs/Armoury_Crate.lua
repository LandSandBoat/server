-----------------------------------
-- Area: Mine Shaft #2716
--  NPC: Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
-----------------------------------
local entity = {}

local loot =
{
    -- ENM: Bionic Bug
    [738] =
    {
        {
            {itemid =    0, droprate = 900}, -- Nothing
            {itemid = 1842, droprate = 100}, -- Cloud Evoker
        },
        {
            {itemid = 1767, droprate = 333}, -- Eltoro Leather
            {itemid = 1762, droprate = 333}, -- Cassia Lumber
            {itemid = 1771, droprate = 334}, -- Dragon Bone
        },
        {
            {itemid =     0, droprate = 625}, -- nothing
            {itemid = 18009, droprate =  75}, -- Martial Knife
            {itemid = 18056, droprate =  75}, -- Martial Scythe
            {itemid = 13695, droprate =  75}, -- Commander's Cape
            {itemid = 15195, droprate = 100}, -- Faerie Hairpin
            {itemid =  4748, droprate =  50}, -- Raise III
        },
        {
            {itemid =     0, droprate = 625}, -- nothing
            {itemid = 18009, droprate =  75}, -- Martial Knife
            {itemid = 18056, droprate =  75}, -- Martial Scythe
            {itemid = 13695, droprate =  75}, -- Commander's Cape
            {itemid = 15195, droprate = 100}, -- Faerie Hairpin
            {itemid =  4748, droprate =  50}, -- Raise III
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
