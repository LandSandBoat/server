-----------------------------------
-- Area: Norg
--  NPC: Magephaud
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local everyonesGrudge = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.EVERYONES_GRUDGE)
    if everyonesGrudge == QUEST_ACCEPTED then
        if
            trade:hasItemQty(xi.item.GOLD_BEASTCOIN, 3) and
            trade:getItemCount() == 3
        then
            player:startEvent(118, xi.item.GOLD_BEASTCOIN)
        end
    end
end

entity.onTrigger = function(player, npc)
    local nFame = player:getFameLevel(xi.quest.fame_area.NORG)

    if
        player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.EVERYONES_GRUDGE) == QUEST_AVAILABLE and
        player:getCharVar('EVERYONES_GRUDGE_KILLS') >= 1 and
        nFame >= 2
    then
        player:startEvent(116, xi.item.GOLD_BEASTCOIN)  -- Quest start - you have tonberry kills?! I got yo back ^.-
    elseif player:getCharVar('EveryonesGrudgeStarted')  == 1 then
        player:startEvent(117, xi.item.GOLD_BEASTCOIN)
    elseif player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.EVERYONES_GRUDGE) == QUEST_COMPLETED then
        player:startEvent(119)  -- After completion cs
    else
        player:startEvent(115)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 116 then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.EVERYONES_GRUDGE)
        player:setCharVar('EveryonesGrudgeStarted', 1)
    elseif csid == 118 then
        player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.EVERYONES_GRUDGE)
        player:tradeComplete()
        player:addFame(xi.quest.fame_area.NORG, 80)
        player:addKeyItem(xi.ki.TONBERRY_PRIEST_KEY)    -- Permanent Tonberry key
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TONBERRY_PRIEST_KEY)
        player:setCharVar('EveryonesGrudgeStarted', 0)
        player:addTitle(xi.title.HONORARY_DOCTORATE_MAJORING_IN_TONBERRIES)
    end
end

return entity
