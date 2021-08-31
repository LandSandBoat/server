-----------------------------------
-- Area: Lower Jeuno
--  NPC: Harnek
-- Starts and Finishes Quest: The Tenshodo Showdown (finish)
-- !pos 44 0 -19 245
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:hasKeyItem(xi.ki.LETTER_FROM_THE_TENSHODO)) then
        player:startEvent(10021, 0, xi.ki.LETTER_FROM_THE_TENSHODO) -- During Quest "The Tenshodo Showdown"
    elseif (player:hasKeyItem(xi.ki.SIGNED_ENVELOPE)) then
        player:startEvent(10022) -- Finish Quest "The Tenshodo Showdown"
    else
        player:startEvent(217) -- Standard dialog
    end

end

-- 12  13  9  10  20  217  159  10021  10022
entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 10021) then
        player:setCharVar("theTenshodoShowdownCS", 2)
        player:delKeyItem(xi.ki.LETTER_FROM_THE_TENSHODO)
        player:addKeyItem(xi.ki.TENSHODO_ENVELOPE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TENSHODO_ENVELOPE)
    elseif (csid == 10022) then
        if (player:getFreeSlotsCount() == 0 or player:hasItem(16764)) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16764) -- Marauder's Knife
        else
            player:delKeyItem(xi.ki.SIGNED_ENVELOPE)
            player:addItem(16764)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16764) -- Marauder's Knife
            player:setCharVar("theTenshodoShowdownCS", 0)
            player:addFame(WINDURST, 30)
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN)
        end
    end

end

return entity
