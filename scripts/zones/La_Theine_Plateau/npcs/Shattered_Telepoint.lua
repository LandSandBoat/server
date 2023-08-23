-----------------------------------
-- Area: La_Theine Plateau
--  NPC: Shattered Telepoint
-- !pos 334 19 -60 102
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS) then
        player:startEvent(202)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 202 and option == 0 then
        player:setPos(-266.76, -0.635, 280.058, 0, 14) -- To Hall of Transference (R)
    end
end

return entity
