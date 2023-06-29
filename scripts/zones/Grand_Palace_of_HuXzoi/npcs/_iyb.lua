-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Particle Gate
-- !pos 1 0.1 -320 34
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY) then
        return player:startEvent(56)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 56 and option == 1 then
        player:setPos(-20, 0.6250, -355.4820, 188, xi.zone.GRAND_PALACE_OF_HUXZOI)
    end
end

return entity
