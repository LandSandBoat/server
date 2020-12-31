-----------------------------------
-- Area: La Theine Plateau
--  NPC:??? (qm3)
-- Involved in Quest: I Can Hear A Rainbow
-----------------------------------
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
    if
        player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.I_CAN_HEAR_A_RAINBOW) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, 1125) and
        utils.mask.isFull(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), 7)
    then
        player:startEvent(124)
    end
end

function onTrigger(player, npc)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Tenzen_s_Path") == 0) then
        player:startEvent(203)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 124) then
        player:completeQuest(WINDURST, tpz.quest.id.windurst.I_CAN_HEAR_A_RAINBOW)
        player:addTitle(tpz.title.RAINBOW_WEAVER)
        player:unlockJob(tpz.job.SMN)
        player:addSpell(296)
        player:messageSpecial(ID.text.UNLOCK_SUMMONER)
        player:messageSpecial(ID.text.UNLOCK_CARBUNCLE)
        player:setCharVar("I_CAN_HEAR_A_RAINBOW", 0)
        player:confirmTrade()

        local rainbow = GetNPCByID(ID.npc.RAINBOW)
        rainbow:setLocalVar('setRainbow', 1)
    elseif (csid == 203) then
        player:setCharVar("COP_Tenzen_s_Path", 1)
    end
end
