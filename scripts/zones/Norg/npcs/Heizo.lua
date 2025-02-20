-----------------------------------
-- Area: Norg
--  NPC: Heizo
-- Starts and Ends Quest: Like Shining Leggings
-- !pos -1 -5 25 252
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local shiningLeggings = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_LEGGINGS)
    local legging = trade:getItemQty(xi.item.RUSTY_LEGGINGS)
    local turnedInVar = player:getCharVar('shiningLeggings_nb')
    local totalLeggings = legging + turnedInVar

    if legging > 0 and legging == trade:getItemCount() then
        if
            shiningLeggings == xi.questStatus.QUEST_ACCEPTED and
            turnedInVar + legging >= 10
        then -- complete quest
            player:startEvent(129)
        elseif shiningLeggings == xi.questStatus.QUEST_ACCEPTED and turnedInVar <= 9 then -- turning in less than the amount needed to finish the quest
            player:tradeComplete()
            player:setCharVar('shiningLeggings_nb', totalLeggings)
            player:startEvent(128, totalLeggings) -- Update player on number of leggings turned in
        end
    else
        if shiningLeggings == xi.questStatus.QUEST_ACCEPTED then
            player:startEvent(128, totalLeggings) -- Update player on number of leggings turned in, but doesn't accept anything other than leggings
        else
            player:startEvent(126) -- Give standard conversation if items are traded but no quest is accepted
        end
    end
end

entity.onTrigger = function(player, npc)
    local shiningLeggings = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_LEGGINGS)

    if
        shiningLeggings == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.NORG) >= 3
    then
        player:startEvent(127) -- Start Like Shining Leggings
    elseif shiningLeggings == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(128, player:getCharVar('shiningSubligar_nb')) -- Update player on number of Leggings turned in
    else
        player:startEvent(126) -- Standard Conversation
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 127 then
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_LEGGINGS)
    elseif csid == 129 then
        player:tradeComplete()
        player:addItem(xi.item.SCROLL_OF_DOKUMORI_ICHI)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.SCROLL_OF_DOKUMORI_ICHI)
        player:addFame(xi.fameArea.NORG, 100)
        player:addTitle(xi.title.LOOKS_GOOD_IN_LEGGINGS)
        player:setCharVar('shiningLeggings_nb', 0)
        player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_LEGGINGS)
    end
end

return entity
