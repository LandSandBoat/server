-----------------------------------
-- Area: Tahrongi_Canyon
--  NPC: Shattered Telepoint
-- !pos 179 35 255 117
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS) then
        player:startEvent(913)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 913 and option == 0 then
        player:setPos(280.066, -80.635, -67.096, 191, 14)
    end
end

return entity
