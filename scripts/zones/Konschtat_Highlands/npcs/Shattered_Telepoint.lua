-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Shattered telepoint
-- !pos 135 19 220 108
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
        player:setPos(-267.194, -40.634, -280.019, 0, 14) -- To Hall of Transference (R)
    end
end

return entity
