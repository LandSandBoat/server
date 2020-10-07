-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Perfaumand
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -39 -3 69 233
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatSandy = player:getCharVar("WildcatSandy")

    -- "Lure of the Wildcat"
    if
        player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        player:getMaskBit(WildcatSandy, 18) == false
    then
        player:startEvent(560)

    -- San d'Oria Missions
    elseif player:getNation() == tpz.nation.SANDORIA and player:getRank() ~= 10 then
        local missions = tpz.mission.id.sandoria
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getCharVar("MissionStatus")

        -- San d'Oria 9-2 "The Heir to the Light" (optional dialogue)
        if currentMission == missions.THE_HEIR_TO_THE_LIGHT and (missionStatus == 2 or missionStatus == 5) then
            if missionStatus == 5 then
                playerStartEvent(7)
            else
                player:startEvent(2)
            end

        -- San d'Oria 6-2 "Ranperre's Final Rest" (optional dialogue)
        elseif currentMission == missions.RANPERRE_S_FINAL_REST then
            if player:hasKeyItem(tpz.ki.ANCIENT_SANDORIAN_BOOK) and missionStatus > 2 and missionStatus < 6 then
                player:startEvent(49)
            elseif missionStatus == 6 then
                player:startEvent(50)
            elseif missionStatus == 7 then
                player:startEvent(79)
            end

        -- Default dialogue
        else
            player:startEvent(522)
        end
    else
        player:startEvent(522)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 560 then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 18, true))
    end

end
