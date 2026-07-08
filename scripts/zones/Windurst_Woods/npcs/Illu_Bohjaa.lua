-----------------------------------
-- Area: Windurst Woods
--  NPC: Illu Bohjaa
-- Involved in the repeatable quest "Creepy Crawlies"
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CREEPY_CRAWLIES) ~= xi.questStatus.QUEST_AVAILABLE then
        if npcUtil.tradeHas(trade, { { 816, 3 } }) then -- silk thread x3
            player:addFame(xi.fameArea.WINDURST, 15)
            player:startEvent(335, 600 * xi.settings.main.GIL_RATE, 816, 938, 1156)
        elseif npcUtil.tradeHas(trade, { { 1156, 3 } }) then -- crawler calculus x3
            player:addFame(xi.fameArea.WINDURST, 30)
            player:startEvent(335, 600 * xi.settings.main.GIL_RATE, 816, 938, 1156)
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CREEPY_CRAWLIES) == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(333, 0, 816, 938, 1156)
    else
        player:startEvent(334, 0, 816, 938, 1156)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 333 and option == 1 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.CREEPY_CRAWLIES)
    elseif csid == 335 then
        player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.CREEPY_CRAWLIES)
        player:addTitle(xi.title.CRAWLER_CULLER)
        player:addGil(600 * xi.settings.main.GIL_RATE)
        player:confirmTrade()
    end
end

return entity
