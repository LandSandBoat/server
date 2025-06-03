-----------------------------------
-- Area: La Theine Plateau
--  NPC: Dimensional Portal
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_WARRIORS_PATH then
        player:startEvent(204)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE + 1) -- Telepoint Disappeared
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 204 and option == 1 then
        player:setPos(25.299, -2.799, 579, 193, 33) -- To AlTaieu (R)
    end
end

return entity
