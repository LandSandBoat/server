-----------------------------------
-- Area: Abyssea-La Theine
--  NPC: Halver
-- Starts and Finishes Quest: Lost Memories
-- !pos: 600 40 -515 132
-----------------------------------
---@type TNpcEntity

local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.LOST_MEMORIES) ~= xi.questStatus.QUEST_AVAILABLE then
        if npcUtil.tradeHas(trade, { { xi.item.LAMBENT_SCALE, 2 } }) then
            player:startEvent(164)
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getFameLevel(xi.fameArea.ABYSSEA_LATHEINE) < 5 then
        player:startEvent(162) -- Insufficient Fame
    elseif
        player:getFameLevel(xi.fameArea.ABYSSEA_LATHEINE) >= 5 and
        player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.LOST_MEMORIES) == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(165) -- Begin quest "Lost Memories"
    elseif player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.LOST_MEMORIES) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(163) -- During and after quest "Lost Memories"
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 165 and option ~= 0 then
        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.LOST_MEMORIES)
    elseif csid == 164 then
        player:addCurrency('cruor', 480)
        player:printToPlayer('You received 480 cruor from Halver') --TODO implement cruor in npc_utils
        player:printToPlayer('You received a Vial of Lambent Potion from Halver') --TODO fix Abyssea messages so this section can be removed.
        npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_LAMBENT_POTION)
        player:completeQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.LOST_MEMORIES)
        player:confirmTrade()
        --TODO add repeat quest?
    end
end

return entity
