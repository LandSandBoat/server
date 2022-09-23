-----------------------------------
-- Area: Port Bastok
--  NPC: Benita
-- Starts Quest: The Wisdom Of Elders
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local count = trade:getItemCount()
    local bombAsh = trade:hasItemQty(928, 1)

    if count == 1 and bombAsh == true then
        local theWisdom = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WISDOM_OF_ELDERS)
        local theWisdomVar = player:getCharVar("TheWisdomVar")
        if theWisdom == 1 and theWisdomVar == 2 then
            player:tradeComplete()
            player:startEvent(176)
        end
    end
end

entity.onTrigger = function(player, npc)
    local theWisdom = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WISDOM_OF_ELDERS)
    local pLevel = player:getMainLvl()

    if theWisdom == 0 and pLevel >= 6 then
        player:startEvent(174)
    else
        local rand = math.random(1, 2)
        if rand == 1 then
            player:startEvent(102)
        else
            player:startEvent(103)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 174 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WISDOM_OF_ELDERS)
        player:setCharVar("TheWisdomVar", 1)
    elseif csid == 176 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12500)
        else
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WISDOM_OF_ELDERS)
            player:addFame(xi.quest.fame_area.BASTOK, 120)
            player:addItem(12500)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12500)
        end
    end
end

return entity
