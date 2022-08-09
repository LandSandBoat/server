-----------------------------------
-- Area: Spire of Mea
-- NPC: Enigmatic Sphere
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

local loot =
{
    -- ENM: Playing Host
    [833] =
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
            {itemid = 1801, droprate = 100}, -- Solemn Vision (Guarding Earring)
            {itemid = 1804, droprate = 100}, -- Valiant Vision (Augmenting Earring)
            {itemid = 1806, droprate = 100}, -- Pretentious Vision (Elemental Earring)
            {itemid = 1809, droprate = 100}, -- Malicious Vision (Ninjutsu Earring)
            {itemid = 1812, droprate = 100}, -- Pristine Vision (Wind Earring)
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
