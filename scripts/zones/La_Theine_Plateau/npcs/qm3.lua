-----------------------------------
-- Area: La Theine Plateau
--  NPC:??? (qm3)
-- Involved in Quest: I Can Hear A Rainbow
-----------------------------------
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, 1125) and
        utils.mask.isFull(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), 7)
    then
        player:startEvent(124)
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 124 then
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW)
        player:addTitle(xi.title.RAINBOW_WEAVER)
        player:unlockJob(xi.job.SMN)
        player:addSpell(296)
        player:messageSpecial(ID.text.UNLOCK_SUMMONER)
        player:messageSpecial(ID.text.UNLOCK_CARBUNCLE)
        player:setCharVar("I_CAN_HEAR_A_RAINBOW", 0)
        player:confirmTrade()

        local rainbow = GetNPCByID(ID.npc.RAINBOW)
        rainbow:setLocalVar('setRainbow', 1)
    end
end

return entity
