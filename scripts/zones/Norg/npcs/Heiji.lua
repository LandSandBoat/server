-----------------------------------
-- Area: Norg
--  NPC: Heiji
-- Starts and Ends Quest: Like a Shining Subligar
-- !pos -1 -5 25 252
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local shiningSubligar = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_SUBLIGAR)
    local subligar = trade:getItemQty(14242)
    local turnedInVar = player:getCharVar("shiningSubligar_nb")
    local totalSubligar = subligar + turnedInVar

    if subligar > 0 and subligar == trade:getItemCount() then
        if shiningSubligar == QUEST_ACCEPTED and turnedInVar + subligar >= 10 then -- complete quest
            player:startEvent(125)
        elseif shiningSubligar == QUEST_ACCEPTED and turnedInVar <= 9 then -- turning in less than the amount needed to finish the quest
            player:tradeComplete()
            player:setCharVar("shiningSubligar_nb", totalSubligar)
            player:startEvent(124, totalSubligar) -- Update player on number of subligar turned in
        end
    else
        if shiningSubligar == QUEST_ACCEPTED then
            player:startEvent(124, totalSubligar) -- Update player on number of subligar turned in, but doesn't accept anything other than subligar
        else
            player:startEvent(122) -- Give standard conversation if items are traded but no quest is accepted
        end
    end
end

entity.onTrigger = function(player, npc)
    local shiningSubligar = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_SUBLIGAR)

    if
        shiningSubligar == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.NORG) >= 3
    then
        player:startEvent(123) -- Start Like a Shining Subligar
    elseif shiningSubligar == QUEST_ACCEPTED then
        player:startEvent(124, player:getCharVar("shiningSubligar_nb")) -- Update player on number of subligar turned in
    else
        player:startEvent(122) -- Standard Conversation
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 123 then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_SUBLIGAR)
    elseif csid == 125 then
        player:tradeComplete()
        player:addTitle(xi.title.LOOKS_SUBLIME_IN_A_SUBLIGAR)
        player:addItem(4955) -- Scroll of Kurayami: Ichi
        player:messageSpecial(ID.text.ITEM_OBTAINED, 4955) -- Scroll of Kurayami: Ichi
        player:setCharVar("shiningSubligar_nb", 0)
        player:addFame(xi.quest.fame_area.NORG, 100)
        player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_SUBLIGAR)
    end
end

return entity
