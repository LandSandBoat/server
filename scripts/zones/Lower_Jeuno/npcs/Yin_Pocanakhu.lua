-----------------------------------
-- Area: Lower Jeuno
--  NPC: Yin Pocanakhu
-- !pos 35 4 -43 245
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(player:getNation()) == xi.mission.id.nation.MAGICITE and
        player:getMissionStatus(player:getNation()) == 3
    then
        player:startEvent(210)
    else
        player:startEvent(209)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
