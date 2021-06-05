-----------------------------------
-- Area: Mhaura
--  NPC: Numi Adaligo
-----------------------------------
-- Used in: scripts/quests/otherAreas/Rycharde_the_Chef.lua
-----------------------------------
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local rovOptionEnable = 0
    if player:getCurrentMission(ROV) == xi.mission.id.rov.EMISSARY_FROM_THE_SEAS and player:getCharVar("RhapsodiesStatus") == 2 then
        rovOptionEnable = 1
    end
    player:startEvent(50, 0, 0, 0, 0, 0, 0, 0, rovOptionEnable)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 50 and option == 1 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.EMISSARY_FROM_THE_SEAS)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.SET_FREE)
    end
end

return entity
