-----------------------------------
-- Area: Upper Jeuno
--  NPC: Osker
-- Involved in Quest: Chocobo's Wounds
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Upper_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    local ANewDawnEvent = player:getCharVar("ANewDawn_Event")

    if (trade:hasItemQty(717, 1) and trade:getItemCount() == 1 and ANewDawnEvent == 3) then
        player:tradeComplete()
        player:startEvent(148)
    end

end

entity.onTrigger = function(player, npc)

    local ANewDawn = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN)
    local ANewDawnEvent = player:getCharVar("ANewDawn_Event")

    local ChocobosWounds = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHOCOBO_S_WOUNDS)
    local feed = player:getCharVar("ChocobosWounds_Event")

    -- A New Dawn
    if (ANewDawn == QUEST_ACCEPTED) then
        if (ANewDawnEvent == 2 or ANewDawnEvent == 3) then
            player:startEvent(146)
        elseif (ANewDawnEvent >= 4) then
            player:startEvent(147)
        end

    -- Chocobos Wounds
    elseif (ChocobosWounds == 0) then
        player:startEvent(62)
    elseif (ChocobosWounds == 1) then
        if (feed == 1) then
            player:startEvent(103)
        elseif (feed == 2) then
            player:startEvent(51)
        elseif (feed == 3) then
            player:startEvent(52)
        elseif (feed == 4) then
            player:startEvent(59)
        elseif (feed == 5) then
            player:startEvent(46)
        elseif (feed == 6) then
            player:startEvent(55)
        end
    elseif (ChocobosWounds == 2) then
        player:startEvent(55)

    -- Standard Dialog 0036 probably isnt correct
    elseif (ANewDawn == QUEST_COMPLETED) then
        player:startEvent(145)
    else
        player:startEvent(54)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    local ANewDawnEvent = player:getCharVar("ANewDawn_Event")

    if (csid == 146) then
        if (ANewDawnEvent == 2) then
            player:setCharVar("ANewDawn_Event", 3)
        end
    elseif (csid == 148) then
        player:addKeyItem(xi.ki.TAMERS_WHISTLE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TAMERS_WHISTLE)
        player:setCharVar("ANewDawn_Event", 4)
    end

end

return entity
