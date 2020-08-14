-----------------------------------
-- Area: Selbina (248)
--  NPC: Naillina
-- Standard Info NPC
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local rovOptionEnable = 0
    if player:getCurrentMission(ROV) == tpz.mission.id.rov.EMISSARY_FROM_THE_SEAS and player:getCharVar("RhapsodiesStatus") == 1 then
        rovOptionEnable = 1
    end
    player:startEvent(14, 0, 0, 0, 0, 0, 0, 0, rovOptionEnable)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 14 and option == 1 then
        player:completeMission(ROV, tpz.mission.id.rov.EMISSARY_FROM_THE_SEAS)
        player:addMission(ROV, tpz.mission.id.rov.SET_FREE)
    end
end
