-----------------------------------
-- Area: Castle Zvahl Keep
--  NPC: Ore door
-- Involved In Quest: Recollections
-- !pos -14 0 69 162
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_KEEP]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.RECOLLECTIONS) == QUEST_ACCEPTED and
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
    return 1
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 8 then
        player:tradeComplete()
        player:setCharVar('recollectionsQuest', 3)
        player:addKeyItem(xi.ki.FOE_FINDER_MK_I)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.FOE_FINDER_MK_I)
    end
end

return entity
