-----------------------------------
-- Area: Metalworks
--  NPC: Mighty Fist
-- Starts & Finishes Quest: The Darksmith (R)
-- Involved in Quest: Dark Legacy
-- !pos -47 2 -30 237
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DARKSMITH) ~= QUEST_AVAILABLE) then
        if (trade:hasItemQty(645, 2) and trade:getItemCount() == 2) then
            player:startEvent(566)
        end
    end
end

entity.onTrigger = function(player, npc)
    if (player:getCharVar("darkLegacyCS") == 1) then
        player:startEvent(752)
    elseif (player:hasKeyItem(xi.ki.DARKSTEEL_FORMULA)) then
        player:startEvent(754)
    elseif (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DARKSMITH) == QUEST_AVAILABLE and player:getFameLevel(BASTOK) >= 3) then
        player:startEvent(565)
    else
        local Message = math.random(0, 1)

        if (Message == 1) then
            player:startEvent(560)
        else
            player:startEvent(561)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 565) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DARKSMITH)
    elseif (csid == 566) then
        local TheDarksmith = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DARKSMITH)

        player:tradeComplete()
        player:addGil(xi.settings.GIL_RATE * 8000)
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.GIL_RATE * 8000)

        if (TheDarksmith == QUEST_ACCEPTED) then
            player:addFame(BASTOK, 30)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DARKSMITH)
        else
            player:addFame(BASTOK, 5)
        end
    elseif (csid == 752) then
        player:setCharVar("darkLegacyCS", 2)
        player:addKeyItem(xi.ki.LETTER_FROM_THE_DARKSTEEL_FORGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTER_FROM_THE_DARKSTEEL_FORGE)
    end
end

return entity
