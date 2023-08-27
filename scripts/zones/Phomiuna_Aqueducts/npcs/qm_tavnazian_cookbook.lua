-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: ??? for Tavnazian Cookbook
-----------------------------------
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------
local entity = {}

local points =
{
    [1]  = { 83.219, -25.047, 8.010 },   -- J-9 on some vases
    [2]  = { -62.6, -26.000, 107.965 },  -- F-7 on a shelf
    [3]  = { -47.454, -26.000, 11.535 }, -- F-9 on a shelf
    [4]  = { 84.827, -26.000, 108.299 }  -- J-7 on a shelf
}

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_HERE)
end

entity.onTimeTrigger = function(npc, triggerID)
    local currentPoint = npc:getLocalVar("currentPoint")
    local nextPoint = currentPoint + 1

    if nextPoint > 4 then
        nextPoint = 1
    end

    local nextPointLoc = points[nextPoint]
    npc:setLocalVar("currentPoint", nextPoint)
    npcUtil.queueMove(npc, nextPointLoc, 1000)
end

entity.onSpawn = function(npc)
    npc:setLocalVar("currentPoint", 1)
end

return entity
