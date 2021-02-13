-----------------------------------
-- Area: Selbina (248)
--  NPC: Naillina
-- Standard Info NPC
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local rovOptionEnable = 0
    if player:getCurrentMission(ROV) == tpz.mission.id.rov.EMISSARY_FROM_THE_SEAS and player:getCharVar("RhapsodiesStatus") == 1 then
        rovOptionEnable = 1
    end
    player:startEvent(14, 0, 0, 0, 0, 0, 0, 0, rovOptionEnable)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 14 and option == 1 then
        player:completeMission(tpz.mission.log_id.ROV, tpz.mission.id.rov.EMISSARY_FROM_THE_SEAS)
        player:addMission(tpz.mission.log_id.ROV, tpz.mission.id.rov.SET_FREE)
    end
end

return entity
