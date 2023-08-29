-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Andecia
-- Starts and Finishes Quest: Grave Concerns
-- !pos 167 0 45 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRAVE_CONCERNS) == QUEST_ACCEPTED then
        if
            trade:hasItemQty(xi.item.TOMB_GUARDS_WATERSKIN, 1) and
            trade:getItemCount() == 1 and
            player:getCharVar('OfferingWaterOK') == 1
        then
            player:startEvent(624)
        end
    end
end

entity.onTrigger = function(player, npc)
    local tomb = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRAVE_CONCERNS)

    if tomb == QUEST_AVAILABLE then
        player:startEvent(541)
    elseif
        tomb == QUEST_ACCEPTED and
        not player:hasItem(xi.item.SKIN_OF_WELL_WATER) and
        player:getCharVar('OfferingWaterOK') == 0
    then
        player:startEvent(622)
    elseif
        tomb == QUEST_ACCEPTED and
        player:hasItem(xi.item.TOMB_GUARDS_WATERSKIN) and
        player:getCharVar('OfferingWaterOK') == 0
    then
        player:startEvent(623)
    elseif tomb == QUEST_COMPLETED then
        player:startEvent(558)
    else
        player:startEvent(540)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 541 and option == 0 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 567) -- Well Water
        else
            player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRAVE_CONCERNS)
            player:setCharVar('graveConcernsVar', 0)
            player:addItem(xi.item.SKIN_OF_WELL_WATER)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.SKIN_OF_WELL_WATER) -- Well Water
        end
    elseif csid == 624 then
        player:tradeComplete()
        player:setCharVar('OfferingWaterOK', 0)
        player:addTitle(xi.title.ROYAL_GRAVE_KEEPER)
        npcUtil.giveCurrency(player, 'gil', 560)
        player:addFame(xi.quest.fame_area.SANDORIA, 30)
        player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRAVE_CONCERNS)
    end
end

return entity
