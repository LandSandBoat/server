-----------------------------------
-- Area: Norg
--  NPC: Heiji
-- Starts and Ends Quest: Like a Shining Subligar
-- !pos -1 -5 25 252
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local shiningSubligar = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_SUBLIGAR)
    local subligar = trade:getItemQty(xi.item.RUSTY_SUBLIGAR)
    local turnedInVar = player:getCharVar('shiningSubligar_nb')
    local totalSubligar = subligar + turnedInVar

    if subligar > 0 and subligar == trade:getItemCount() then
        if
            shiningSubligar == xi.questStatus.QUEST_ACCEPTED and
            turnedInVar + subligar >= 10
        then -- complete quest
            player:startEvent(125)
        elseif shiningSubligar == xi.questStatus.QUEST_ACCEPTED and turnedInVar <= 9 then -- turning in less than the amount needed to finish the quest
            player:tradeComplete()
            player:setCharVar('shiningSubligar_nb', totalSubligar)
            player:startEvent(124, totalSubligar) -- Update player on number of subligar turned in
        end
    else
        if shiningSubligar == xi.questStatus.QUEST_ACCEPTED then
            player:startEvent(124, totalSubligar) -- Update player on number of subligar turned in, but doesn't accept anything other than subligar
        else
            player:startEvent(122) -- Give standard conversation if items are traded but no quest is accepted
        end
    end
end

entity.onTrigger = function(player, npc)
    local shiningSubligar = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_SUBLIGAR)

    if
        shiningSubligar == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.NORG) >= 3
    then
        player:startEvent(123) -- Start Like a Shining Subligar
    elseif shiningSubligar == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(124, player:getCharVar('shiningSubligar_nb')) -- Update player on number of subligar turned in
    else
        player:startEvent(122) -- Standard Conversation
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 123 then
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_SUBLIGAR)
    elseif csid == 125 then
        player:tradeComplete()
        player:addTitle(xi.title.LOOKS_SUBLIME_IN_A_SUBLIGAR)
        player:addItem(xi.item.SCROLL_OF_KURAYAMI_ICHI)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.SCROLL_OF_KURAYAMI_ICHI)
        player:setCharVar('shiningSubligar_nb', 0)
        player:addFame(xi.fameArea.NORG, 100)
        player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_SUBLIGAR)
    end
end

return entity
