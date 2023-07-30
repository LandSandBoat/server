-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Cast Metal Plate)
-- !pos 152.654 -14.225 -146.770
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local points =
    {
        { 152.654, -14.225, -146.770 },
        { 258.449, -16.209, -220.908 },
        { 389.521, -14.311, -228.919 },
        { 462.338, -15.541, -59.217 },
        { 600.102, -17.890, 14.216 },
        { 732.790, -22.990, 19.116 },
        { 617.666, -24.054, 102.911 },
        { 570.851, -25.235, 212.295 },
        { 789.204, -21.883, 329.779 },
    }

    if
        player:getLocalVar("CheckedHalvungGate") == 1 and
        not player:hasKeyItem(xi.ki.CAST_METAL_PLATE)
    then
        npcUtil.giveKeyItem(player, xi.ki.CAST_METAL_PLATE)
        player:setLocalVar("CheckedHalvungGate", 0)

        local nextPos = points[math.random(1, #points)]
        npc:setPos(nextPos[1], nextPos[2], nextPos[3], 0)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
