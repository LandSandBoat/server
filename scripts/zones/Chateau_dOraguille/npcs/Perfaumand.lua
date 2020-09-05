-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Perfaumand
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -39 -3 69 233
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatSandy = player:getCharVar("WildcatSandy")
    local currentMission = player:getCurrentMission(SANDORIA)
    local missionStatus = player:getCharVar("MissionStatus")

    if currentMission == tpz.mission.id.sandoria.RANPERRE_S_FINAL_REST and ((player:hasKeyItem(tpz.ki.ANCIENT_SANDORIAN_BOOK) and missionStatus == 3) or missionStatus == 4 or missionStatus == 5) then
        player:startEvent(49) -- Optional 6-2 CS
    elseif currentMission == tpz.mission.id.sandoria.RANPERRE_S_FINAL_REST and missionStatus == 6 then
        player:startEvent(50) -- Optional 6-2 CS
    elseif currentMission == tpz.mission.id.sandoria.RANPERRE_S_FINAL_REST and missionStatus == 7 then
        player:startEvent(79) -- Optional 6-2 CS
    elseif player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatSandy, 18) == false then
        player:startEvent(560)
    else
        player:startEvent(522)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 560 then
        player:setMaskBit(player:getCharVar("WildcatSandy"), "WildcatSandy", 18, true)
    end

end
