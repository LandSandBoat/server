-----------------------------------
-- Area: Spire of Vahzl
-- NPC:  Enigmatic Sphere
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

local loot =
{
    -- ENM: Pulling the Plug
    [865] =
    {
        {
            {itemid =  5287, droprate =   97}, -- Bitter Cluster
            {itemid =  5286, droprate =  174}, -- Burning Cluster
            {itemid =  5288, droprate =  124}, -- Fleeting Cluster
            {itemid =  5293, droprate =  140}, -- Malevolent Cluster
            {itemid =  5289, droprate =  124}, -- Profane Cluster
            {itemid =  5292, droprate =  124}, -- Radiant Cluster
            {itemid =  5291, droprate =   93}, -- Somber Cluster
            {itemid =  5290, droprate =  124}, -- Startling Cluster
        },
        {
            {itemid =  1794, droprate =  291}, -- Beatific Image
            {itemid =  1793, droprate =  372}, -- Grave Image
            {itemid =  1795, droprate =  337}, -- Valorous Image
        },
        {
            {itemid =  1796, droprate =  523}, -- Ancient Image
            {itemid =  1797, droprate =  477}, -- Virgin Image
        },
        {
            {itemid =     0, droprate =  736}, -- nothing
            {itemid =  1790, droprate =  167}, -- Impetuous Vision
            {itemid =  1792, droprate =   66}, -- Snide Vision
            {itemid =  1791, droprate =   31}, -- Tenuous Vision
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
