-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Halver
-- Involved in Mission 2-3, 3-3, 5-1, 5-2, 8-1
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos 2 0.1 0.1 233
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()
    local currentMission = player:getCurrentMission(pNation)
    local WildcatSandy = player:getCharVar("WildcatSandy")
    local missionStatus = player:getMissionStatus(player:getNation())

    -- Lure of the Wildcat San d'Oria
    if (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatSandy, 16)) then
        player:startEvent(558)
    -- Blackmail quest
    elseif (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL) == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)) then
        player:startEvent(549)
        player:setCharVar("BlackMailQuest", 1)
        player:delKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.CONFESSIONS_OF_ROYALTY and player:hasKeyItem(xi.ki.RAILLEFALS_LETTER)) then
        player:startEvent(564)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.EASTERLY_WINDS and player:getCharVar("AhtUrganStatus") == 0) then
        player:startEvent(565)
    elseif (pNation == xi.nation.SANDORIA) then
        -- Rank 10 default dialogue
        if player:getRank(player:getNation()) == 10 then
            player:startEvent(31)
        -- Default dialogue
        else
            player:startEvent(577)
        end
    elseif (pNation == xi.nation.BASTOK) then
        player:showText(npc, ID.text.HALVER_OFFSET+1092)
    elseif (pNation == xi.nation.WINDURST) then
        -- Windurst 2-3
        if (currentMission == xi.mission.id.windurst.THE_THREE_KINGDOMS and missionStatus < 3) then
            player:startEvent(532)
        elseif (currentMission == xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA or currentMission == xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA2) then
            if (missionStatus == 3) then
                player:startEvent(502)
            elseif (missionStatus == 8) then
                player:startEvent(504)
            else
                player:showText(npc, ID.text.HALVER_OFFSET+279)
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 502) then
        player:setMissionStatus(player:getNation(), 4)
    elseif (csid == 558) then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 16, true))
    elseif (csid == 504) then
        player:setMissionStatus(player:getNation(), 9)
    elseif (csid == 564 and option == 1) then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.CONFESSIONS_OF_ROYALTY)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.EASTERLY_WINDS)
        player:delKeyItem(xi.ki.RAILLEFALS_LETTER)
        player:setCharVar("AhtUrganStatus", 1)
    end
end

return entity
