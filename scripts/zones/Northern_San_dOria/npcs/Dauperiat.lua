-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Dauperiat
-- Starts and Finishes Quest: Blackmail (R)
-- !zone 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local black = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)
    local questState = player:getCharVar('BlackMailQuest')

    if
        black == xi.questStatus.QUEST_ACCEPTED and
        questState == 2 or
        black == xi.questStatus.QUEST_COMPLETED
    then
        if
            trade:hasItemQty(xi.item.COPY_OF_THE_CASTLE_FLOOR_PLANS, 1) and
            trade:getItemCount() == 1
        then
            player:startEvent(648, 0, xi.item.COPY_OF_THE_CASTLE_FLOOR_PLANS)
        end
    end
end

entity.onTrigger = function(player, npc)
    -- "Blackmail" quest status
    local blackMail = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)
    local sanFame = player:getFameLevel(xi.fameArea.SANDORIA)
    local homeRank = player:getRank(player:getNation())
    local questState = player:getCharVar('BlackMailQuest')

    if
        blackMail == xi.questStatus.QUEST_AVAILABLE and
        sanFame >= 3 and
        homeRank >= 3
    then
        player:startEvent(643) -- 643 gives me letter
    elseif
        blackMail == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)
    then
        player:startEvent(645)  -- 645 recap, take envelope!

    elseif blackMail == xi.questStatus.QUEST_ACCEPTED and questState == 1 then
        player:startEvent(646, 0, xi.item.COPY_OF_THE_CASTLE_FLOOR_PLANS)

    elseif blackMail == xi.questStatus.QUEST_ACCEPTED and questState == 2 then
        player:startEvent(647, 0, xi.item.COPY_OF_THE_CASTLE_FLOOR_PLANS)

    else
        if player:needToZone() then
            player:startEvent(642) --642 Quiet!
        else
            player:startEvent(641) --641 -- Quiet! leave me alone
            player:needToZone(true)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 643 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)
        npcUtil.giveKeyItem(player, xi.ki.SUSPICIOUS_ENVELOPE)
    elseif csid == 646 and option == 1 then
        player:setCharVar('BlackMailQuest', 2)
    elseif csid == 648 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 900)
        if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.BLACKMAIL) == xi.questStatus.QUEST_ACCEPTED then
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)
        else
            player:addFame(xi.fameArea.SANDORIA, 5)
        end
    elseif csid == 40 and option == 1 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)
    end
end

return entity
