-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Papal Chambers
--  Finish Mission: The Davoi Report
-- !pos 131 -11 122 231
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.THE_DAVOI_REPORT and player:hasKeyItem(tpz.ki.TEMPLE_KNIGHTS_DAVOI_REPORT)) then
        player:startEvent(695) -- Finish Mission "The Davoi Report"
    elseif (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.PRESTIGE_OF_THE_PAPSQUE and player:getCharVar("MissionStatus") == 0) then
        player:startEvent(7)
    elseif (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.PRESTIGE_OF_THE_PAPSQUE and player:getCharVar("MissionStatus") == 1) then
        player:startEvent(9)
    elseif (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.PRESTIGE_OF_THE_PAPSQUE and player:hasKeyItem(tpz.ki.ANCIENT_SANDORIAN_TABLET)) then
        player:startEvent(8)
    end
    return 1

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 695 or csid == 7 or csid == 8) then
        finishMissionTimeline(player, 3, csid, option)
    end

end
