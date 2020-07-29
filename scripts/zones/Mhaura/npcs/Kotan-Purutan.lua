-----------------------------------
-- Area: Mhaura
--  NPC: Kotan-Purutan
--  Involved in Quest: Overnight Delivery
-- !pos 40.323 -8.999 44.242 249
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local OvernightDelivery = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.OVERNIGHT_DELIVERY)
    local KenapaOvernight = player:getCharVar("Kenapa_Overnight_var") -- Variable to track progress for Overnight Delivery
    local KenapaOvernightDay = player:getCharVar("Kenapa_Overnight_Day_var") -- Variable to track the day the quest is started.
    local KenapaOvernightHour = player:getCharVar("Kenapa_Overnight_Hour_var") -- Variable to track the hour the quest is started.
    local HourOfTheDay = VanadielHour()

    if (OvernightDelivery == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.SMALL_BAG) == false and (KenapaOvernight >= 4 and KenapaOvernight <= 7) and (HourOfTheDay < 6 or HourOfTheDay >= 18)) then
        player:startEvent(141) -- Gives Key Item at correct times of night
    elseif (OvernightDelivery == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.SMALL_BAG) == false and (KenapaOvernight >= 4 and KenapaOvernight <= 7) and (HourOfTheDay >= 6 or HourOfTheDay < 18)) then
        player:startEvent(144) -- Only at night
    elseif (player:hasKeyItem(tpz.ki.SMALL_BAG) == true) then
        player:startEvent(142)  -- Reminder Dialogue
    elseif (OvernightDelivery == QUEST_COMPLETED) then
        player:startEvent(143) -- Post quest
    else
        player:startEvent(140) -- Standard
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 141) then
        player:addKeyItem(tpz.ki.SMALL_BAG)
        player:setCharVar("Kenapa_Overnight_Day_var", VanadielDayOfTheYear())
        player:setCharVar("Kenapa_Overnight_Hour_var", VanadielHour())
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SMALL_BAG)
    end
end
