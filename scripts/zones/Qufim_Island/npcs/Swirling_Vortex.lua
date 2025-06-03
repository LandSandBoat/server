-----------------------------------
-- Area: Qufim Island
--  NPC: Swirling Vortex
-- Entrance to Qufim Island
-- !pos -436.000 -13.499 340.117 126
-----------------------------------
local ID = zones[xi.zone.QUFIM_ISLAND]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS) then
        player:startEvent(300)
    else
        player:messageSpecial(ID.text.AN_EMPTY_LIGHT_SWIRLS)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 300 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.MISAREAUX_VORTEX)
    end
end

return entity
