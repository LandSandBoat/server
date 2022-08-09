-----------------------------------
-- Area: Spire of Holla
-- NPC: Enigmatic Sphere
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

local loot =
{
    -- ENM: Simulant
    [769] =
    {
        {
            {itemid =    0, droprate = 200}, -- Nothing
            {itemid = 5287, droprate = 100}, -- Bitter Cluster
            {itemid = 5286, droprate = 100}, -- Burning Cluster
            {itemid = 5288, droprate = 100}, -- Fleeting Cluster
            {itemid = 5289, droprate = 100}, -- Profane Cluster
            {itemid = 5290, droprate = 100}, -- Startling Cluster
            {itemid = 5291, droprate = 100}, -- Somber Cluster
            {itemid = 5292, droprate = 100}, -- Radiant Cluster
            {itemid = 5293, droprate = 100}, -- Malevolent Cluster
        },
        {
            {itemid =    0, droprate = 200}, -- Nothing
            {itemid = 5287, droprate = 100}, -- Bitter Cluster
            {itemid = 5286, droprate = 100}, -- Burning Cluster
            {itemid = 5288, droprate = 100}, -- Fleeting Cluster
            {itemid = 5293, droprate = 100}, -- Malevolent Cluster
            {itemid = 5289, droprate = 100}, -- Profane Cluster
            {itemid = 5292, droprate = 100}, -- Radiant Cluster
            {itemid = 5291, droprate = 100}, -- Somber Cluster
            {itemid = 5290, droprate = 100}, -- Startling Cluster
        },
        {
            {itemid =    0, droprate = 200}, -- Nothing
            {itemid = 5287, droprate = 100}, -- Bitter Cluster
            {itemid = 5286, droprate = 100}, -- Burning Cluster
            {itemid = 5288, droprate = 100}, -- Fleeting Cluster
            {itemid = 5293, droprate = 100}, -- Malevolent Cluster
            {itemid = 5289, droprate = 100}, -- Profane Cluster
            {itemid = 5292, droprate = 100}, -- Radiant Cluster
            {itemid = 5291, droprate = 100}, -- Somber Cluster
            {itemid = 5290, droprate = 100}, -- Startling Cluster
        },
        {
            {itemid =    0, droprate = 500}, -- Nothing
            {itemid = 1798, droprate = 100}, -- Vernal Vision (Evasion Earring)
            {itemid = 1799, droprate = 100}, -- Punctilious Vision (Parrying Earring)
            {itemid = 1802, droprate = 100}, -- Audacious Vision (Divine Earring)
            {itemid = 1807, droprate = 100}, -- Vivid Vision (Healing Earring)
            {itemid = 1810, droprate = 100}, -- Endearing Vision (Singing Earring)
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
