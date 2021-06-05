-----------------------------------
-- Area: Southern San d'Oria
--  NPC: A.M.A.N Liaison
-----------------------------------
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local firstStepForwardCompleted = player:getEminenceCompleted(1)
    local assistChannelCompleted = player:getEminenceCompleted(1448)
    local assistChannelProgress = player:getEminenceProgress(1448)

    if firstStepForwardCompleted and assistChannelCompleted then
        player:startEvent(3617)
    elseif firstStepForwardCompleted == false then
        player:startEvent(3618)
    elseif assistChannelProgress == nil then
        player:startEvent(3618, 128)
    else
        player:startEvent(3619)
    end
end

entity.onEventUpdate = function(player, csid, option)
    -- TODO: Update Time remaining in for Assist Channel access (single capture below), option 1
    -- Event Update (0x05C): Params: 601965960, 167700, 0, 1, 66453503, 3449826, 4095, 131169
end

entity.onEventFinish = function(player, csid, option)
    if csid == 3619 then
        if player:getEminenceProgress(1448) ~= nil then
            xi.roe.onRecordTrigger(player, 1448)
        end
    end
end

return entity
