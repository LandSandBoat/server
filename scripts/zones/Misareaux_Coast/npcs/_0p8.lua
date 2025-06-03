-----------------------------------
-- Area: Misareaux Coast
--  NPC: Iron Gate
--  Entrance to Sacrarium
-----------------------------------
local ID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SECRETS_OF_WORSHIP) then
        player:startEvent(502)
    else
        player:messageSpecial(ID.text.DOOR_CLOSED)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 502 and option == 1 then
        player:setPos(-220.075, -15.999, 79.634, 62, 28) -- To Sacrarium (R)
    end
end

return entity
