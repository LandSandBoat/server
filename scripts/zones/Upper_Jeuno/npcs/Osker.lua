-----------------------------------
-- Area: Upper Jeuno
--  NPC: Osker
-- Involved in Quest: Chocobo's Wounds
-----------------------------------
require("scripts/settings/main")
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

    -- A New Dawn
    if (ANewDawn == QUEST_ACCEPTED) then
        if (ANewDawnEvent == 2 or ANewDawnEvent == 3) then
            player:startEvent(146)
        elseif (ANewDawnEvent >= 4) then
            player:startEvent(147)
        end

    -- Standard Dialog 54 probably isnt correct (Which is why its not living in DefaultActions)
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
