-----------------------------------
-- Area: Norg
--  NPC: Heillal
-- Standard Info NPC
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(ROV) == xi.mission.id.rov.THE_BEGINNING then
        player:startEvent(281)
    else
        player:startEvent(64)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
