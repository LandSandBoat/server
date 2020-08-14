-----------------------------------
-- Area: Western Adoulin
--  NPC: Kongramm
-- Type: Standard NPC, Mission NPC, and Quest NPC
--  Involved with Mission: 'A Curse From The Past'
--  Involved with Quests: 'A Certain Substitute Patrolman' and 'Transporting'
-- !pos 61 32 138 256
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local SOA_Mission = player:getCurrentMission(SOA)
    local ACSP = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.A_CERTAIN_SUBSTITUTE_PATROLMAN)
    local Transporting = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.TRANSPORTING)

    if ((SOA_Mission == tpz.mission.id.soa.A_CURSE_FROM_THE_PAST) and (not player:hasKeyItem(tpz.ki.PIECE_OF_A_STONE_WALL))) then
        if (player:getCharVar("SOA_ACFTP_Kongramm") < 1) then
            -- Gives hint for SOA Mission: 'A Curse From the Past'
            player:startEvent(148)
        else
            -- Reminds player of hint for SOA Mission: 'A Curse From the Past'
            player:startEvent(149)
        end
    elseif ((Transporting == QUEST_ACCEPTED) and (player:getCharVar("Transporting_Status") < 1)) then
        -- Progresses Quest: 'Transporting'
        player:startEvent(2592)
    elseif ((ACSP == QUEST_ACCEPTED) and (player:getCharVar("ACSP_NPCs_Visited") == 3)) then
        -- Progresses Quest: 'A Certain Substitute Patrolman'
        player:startEvent(2555)
    else
        -- Standard dialogue
        player:startEvent(558)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 148) then
        -- Gave hint for SOA Mission: 'A Curse From the Past'
        player:setCharVar("SOA_ACFTP_Kongramm", 1)
    elseif (csid == 2592) then
        -- Progresses Quest: 'Transporting'
        player:setCharVar("Transporting_Status", 1)
    elseif (csid == 2555) then
        -- Progresses Quest: 'A Certain Substitute Patrolman'
        player:setCharVar("ACSP_NPCs_Visited", 4)
    end
end
