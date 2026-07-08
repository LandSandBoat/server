-----------------------------------
-- Area: Misareaux Coast
--  NPC: Spatial Displacement
-- Entrance to Riverne Site #A01 and #B01
-- !pos -540 -30 360 25
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.SHELTERING_DOUBT) then
        player:startEvent(551) -- Access to Sites A & B
    else
        player:startEvent(550) -- Access to Site A Only
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if (csid == 551 or csid == 550) and option == 1 then
        player:setPos(732.55, -32.5, -506.544, 90, 30) -- Go to Riverne #A01 (R)
    elseif csid == 551 and option == 2 then
        player:setPos(729.749, -20.319, 407.153, 90, 29) -- Go to Riverne #B01 (R)
    end
end

return entity
