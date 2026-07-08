-----------------------------------
-- Area: Castle Zvahl Keep
--  NPC: Ore door
-- Involved In Quest: Recollections
-- !pos -14 0 69 162
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.RECOLLECTIONS) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('recollectionsQuest') == 2
    then
        if
            trade:hasItemQty(xi.item.WHINE_CELLAR_KEY, 1) and
            trade:getItemCount() == 1
        then
            player:startEvent(8, xi.item.WHINE_CELLAR_KEY)
        end
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(9)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 8 then
        player:tradeComplete()
        player:setCharVar('recollectionsQuest', 3)
        npcUtil.giveKeyItem(player, xi.ki.FOE_FINDER_MK_I)
    end
end

return entity
