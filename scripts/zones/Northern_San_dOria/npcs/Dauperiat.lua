-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Dauperiat
-- Starts and Finishes Quest: Blackmail (R)
-- !zone 231
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local black = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)
    local questState = player:getCharVar("BlackMailQuest")

    if black == QUEST_ACCEPTED and questState == 2 or black == QUEST_COMPLETED then
        if trade:hasItemQty(530, 1) and trade:getItemCount() == 1 then
            player:startEvent(648, 0, 530) --648
        end
    end
end

entity.onTrigger = function(player, npc)
    -- "Blackmail" quest status
    local blackMail = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)
    local sanFame = player:getFameLevel(xi.quest.fame_area.SANDORIA)
    local homeRank = player:getRank(player:getNation())
    local questState = player:getCharVar("BlackMailQuest")

    if blackMail == QUEST_AVAILABLE and sanFame >= 3 and homeRank >= 3 then
        player:startEvent(643) -- 643 gives me letter
    elseif
        blackMail == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)
    then
        player:startEvent(645)  -- 645 recap, take envelope!

    elseif blackMail == QUEST_ACCEPTED and questState == 1 then
        player:startEvent(646, 0, 530) --646  after giving letter to H, needs param

    elseif blackMail == QUEST_ACCEPTED and questState == 2 then
        player:startEvent(647, 0, 530) --647 recap of 646

    else
        if player:needToZone() then
            player:startEvent(642) --642 Quiet!
        else
            player:startEvent(641) --641 -- Quiet! leave me alone
            player:needToZone(true)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 643 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)
        player:addKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SUSPICIOUS_ENVELOPE)
    elseif csid == 646 and option == 1 then
        player:setCharVar("BlackMailQuest", 2)
    elseif csid == 648 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 900)
        if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL) == QUEST_ACCEPTED then
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)
        else
            player:addFame(xi.quest.fame_area.SANDORIA, 5)
        end
    elseif csid == 40 and option == 1 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)
    end
end

return entity
