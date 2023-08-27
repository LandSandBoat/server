-----------------------------------
-- Area: Sacrarium
--  NPC: ??? for Tavnazian Cookbook
-----------------------------------
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Sacrarium/IDs")
-----------------------------------
local entity = {}

local points =
{
    [1]  = { 11.720, -3.999, -99.957 },  -- H-11 on a shelf
    [2]  = { 108.300, -3.999, -99.957 }, -- F-11 on a shelf
    [3]  = { 108.300, -3.999, 99.957 },  -- H-5 on a shelf
    [4]  = { 11.720, -3.999, 99.957 }    -- F-5 on a shelf
}

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
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
