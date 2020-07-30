-----------------------------------
-- Area: Western Adoulin
--  NPC: Rising Solstice
-- Type: Standard NPC and Quest Giver
-- Starts, Involved With, and Finishes Quest: 'A Certain Substitute Patrolman'
-- !pos -154 4 -29 256
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local ACSP = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.A_CERTAIN_SUBSTITUTE_PATROLMAN)
    local SOA_Mission = player:getCurrentMission(SOA)

    if (SOA_Mission >= tpz.mission.id.soa.LIFE_ON_THE_FRONTIER) then
        if (ACSP == QUEST_ACCEPTED) then
            -- Finishing Quest: 'A Certain Substitute Patrolman'
            if (player:getCharVar("ACSP_NPCs_Visited") >= 8) then
                player:startEvent(2552)
            -- During Quest: 'A Certain Substitute Patrolman'
            else
                player:startEvent(2551)
            end
        -- Starts Quest: 'A Certain Substitute Patrolman'
        elseif (ACSP == QUEST_AVAILABLE) then
            player:startEvent(2550)
        else
            if ((SOA_Mission >= tpz.mission.id.soa.BEAUTY_AND_THE_BEAST) and (SOA_Mission <= tpz.mission.id.soa.SALVATION)) then
                -- Speech while Arciela is 'kidnapped'
                player:startEvent(150)
            else
                -- Standard dialogue, after joining colonization effort
                player:startEvent(580)
            end
        end
    else
        -- Dialogue prior to joining colonization effort
        player:startEvent(502)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 2550) then
        -- Starting Quest: 'A Certain Substitute Patrolman'
        player:addQuest(ADOULIN, tpz.quest.id.adoulin.A_CERTAIN_SUBSTITUTE_PATROLMAN)
        player:addKeyItem(tpz.ki.WESTERN_ADOULIN_PATROL_ROUTE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WESTERN_ADOULIN_PATROL_ROUTE)
        player:setCharVar("ACSP_NPCs_Visited", 1)
    elseif (csid == 2552) then
        -- Finishing Quest: 'A Certain Substitute Patrolman'
        player:completeQuest(ADOULIN, tpz.quest.id.adoulin.A_CERTAIN_SUBSTITUTE_PATROLMAN)
        player:addExp(1000 * EXP_RATE)
        player:addCurrency('bayld', 500 * BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, 500 * BAYLD_RATE)
        player:delKeyItem(tpz.ki.WESTERN_ADOULIN_PATROL_ROUTE)
        player:addFame(ADOULIN)
        player:setCharVar("ACSP_NPCs_Visited", 0)
    end
end
