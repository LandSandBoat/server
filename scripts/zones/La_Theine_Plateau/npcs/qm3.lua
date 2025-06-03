-----------------------------------
-- Area: La Theine Plateau
--  NPC:??? (qm3)
-- Involved in Quest: I Can Hear A Rainbow
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW) == xi.questStatus.QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, xi.item.CARBUNCLES_RUBY) and
        utils.mask.isFull(player:getCharVar('I_CAN_HEAR_A_RAINBOW'), 7)
    then
        player:startEvent(124)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 124 then
        player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW)
        player:addTitle(xi.title.RAINBOW_WEAVER)
        player:unlockJob(xi.job.SMN)
        player:addSpell(xi.magic.spell.CARBUNCLE)
        player:messageSpecial(ID.text.UNLOCK_SUMMONER)
        player:messageSpecial(ID.text.UNLOCK_CARBUNCLE)
        player:setCharVar('I_CAN_HEAR_A_RAINBOW', 0)
        player:confirmTrade()

        local rainbow = GetNPCByID(ID.npc.RAINBOW)
        if rainbow then
            rainbow:setLocalVar('setRainbow', 1)
        end
    end
end

return entity
