-----------------------------------
-- Area: Spire of Dem
-- NPC: Enigmatic Sphere
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

local loot =
{
    -- ENM: You are what you eat
    [801] =
    {
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
            {itemid = 1800, droprate = 100}, -- Violent Vision (Buckler Earring)
            {itemid = 1803, droprate = 100}, -- Painful Vision (Dark Earring)
            {itemid = 1805, droprate = 100}, -- Timorous Vision (Enfeebling Earring)
            {itemid = 1808, droprate = 100}, -- Brilliant Vision (Summoning earring)
            {itemid = 1811, droprate = 100}, -- Venerable Vision(String Earring)
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
