-----------------------------------
-- Area: Port Windurst
--  NPC: Kohlo-Lakolo
-- Invloved In Quests:
-- Truth, Justice, and the Onion Way!,
-- Know One's Onions,
-- Inspector's Gadget,
-- Onion Rings,
-- Crying Over Onions,
-- Wild Card,
-- The Promise
-- !pos -26.8 -6 190 240
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/settings/main")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local OnionRings           = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS)
    local CryingOverOnions     = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS)
    local WildCard             = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WILD_CARD)
    local ThePromise           = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PROMISE)
    local Level                = player:getMainLvl()
    local Fame                 = player:getFameLevel(WINDURST)

    if
        OnionRings == QUEST_AVAILABLE and
        player:getLocalVar('InspectorsGadgetZone') == 0 and Fame >=3 and not player:hasKeyItem(xi.ki.OLD_RING)
    then
        player:startEvent(429)
    elseif (OnionRings == QUEST_ACCEPTED or OnionRings == QUEST_AVAILABLE) and player:hasKeyItem(xi.ki.OLD_RING) then
        player:startEvent(430, 0, xi.ki.OLD_RING) --TODO get correct time for quest to expire.
    elseif CryingOverOnions == QUEST_AVAILABLE and OnionRings == QUEST_COMPLETED and Fame >=3 then
        player:startEvent(496)
    elseif CryingOverOnions == QUEST_ACCEPTED and player:getCharVar("CryingOverOnions") == 3 then
        player:startEvent(497)
    elseif WildCard == QUEST_ACCEPTED then
        player:startEvent(505)
    elseif ThePromise == QUEST_AVAILABLE and WildCard == QUEST_COMPLETED and Fame >=6 then
        player:startEvent(513, 0, xi.ki.INVISIBLE_MAN_STICKER)
    elseif ThePromise == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.INVISIBLE_MAN_STICKER) then
        player:startEvent(522, 0, xi.ki.INVISIBLE_MAN_STICKER)
    elseif ThePromise == QUEST_COMPLETED then
        player:startEvent(544)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 429 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS)
    elseif csid == 430 then
        if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS) == QUEST_AVAILABLE then
            player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS)
        end
        player:setCharVar("OnionRings", 1)
    elseif csid == 496 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS)
    elseif csid == 497 then
        player:setCharVar("CryingOverOnions", 4)
    elseif csid == 505 then
        player:setCharVar("WildCard", 1)
    elseif csid == 513 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PROMISE)
    elseif csid == 522 then
        if npcUtil.giveItem(player, xi.items.PROMISE_BADGE) then
            npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.THE_PROMISE)
        end
    end
end

return entity
