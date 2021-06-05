-----------------------------------
-- Area: Windurst Waters
--  NPC: Kenapa Keppa
-- Involved in Quest: Food For Thought, Hat in Hand
-- !pos 27 -6 -199 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local foodForThought = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FOOD_FOR_THOUGHT)
    local kenapaFood = player:getCharVar("Kenapa_Food_var") -- Variable to track progress of Kenapa-Keppa in Food for Thought

    if foodForThought == QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, 4409) then -- hard-boiled_egg
            if kenapaFood < 3 then -- Traded item without receiving order
                if math.random(1, 2) == 1 then
                    player:startEvent(331)
                else
                    player:startEvent(330, 120)
                end
            elseif kenapaFood == 3 then -- Traded item after receiving order
                player:startEvent(327, 120)
            end
        else
            player:startEvent(329) -- trade not accepted
        end
    end
end

entity.onTrigger = function(player, npc)
    local overnightDelivery = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.OVERNIGHT_DELIVERY)
    local foodForThought = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FOOD_FOR_THOUGHT)
    local sayItWithFlowers = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)
    local flowerProgress = player:getCharVar("FLOWER_PROGRESS") -- progress of Say It with Flowers
    local kenapaFood = player:getCharVar("Kenapa_Food_var") -- progress of Kenapa-Keppa in Food for Thought
    local kenapaOvernight = player:getCharVar("Kenapa_Overnight_var") -- progress for Overnight Delivery
    local kenapaOvernightDay = player:getCharVar("Kenapa_Overnight_Day_var") -- day the quest is started
    local kenapaOvernightHour = player:getCharVar("Kenapa_Overnight_Hour_var") -- hour the quest is started
    local needToZone = player:needToZone()
    local pFame = player:getFameLevel(WINDURST)
    local vHour = VanadielHour()

    if player:hasKeyItem(xi.ki.NEW_MODEL_HAT) and not utils.mask.getBit(player:getCharVar("QuestHatInHand_var"), 2) then
        player:messageSpecial(ID.text.YOU_SHOW_OFF_THE, 0, xi.ki.NEW_MODEL_HAT)
        player:startEvent(56)
    elseif (sayItWithFlowers == QUEST_ACCEPTED or sayItWithFlowers == QUEST_COMPLETED) and flowerProgress == 2 then
        player:startEvent(519)
    elseif foodForThought == QUEST_AVAILABLE then
        player:startEvent(310) -- Hungry script
    elseif foodForThought == QUEST_ACCEPTED then
        if kenapaFood == 0 then
            player:startEvent(318) -- Stammer 1/3
        elseif kenapaFood == 1 then
            player:startEvent(319) -- Stammer 2/3
        elseif kenapaFood == 2 then
            player:startEvent(320, 0, 4409) -- Gives Order
        elseif kenapaFood == 3 then
            local rand = math.random(1, 3)

            if rand == 1 then
                player:startEvent(320, 0, 4409) -- Repeats Order
            elseif rand == 2 then
                player:startEvent(321) -- "Or Whatever"
            else
                player:startEvent(328) -- "..<Grin>.."
            end
        elseif kenapaFood == 4 then -- Give standard conversation options if this NPC has been fed but others haven't
            if math.random(1, 2) == 1 then
                player:startEvent(302) -- Standard converstation
            else
                player:startEvent(303) -- Standard converstation
            end
        end
    elseif
        foodForThought == QUEST_COMPLETED and
        overnightDelivery == QUEST_AVAILABLE and
        not needToZone and
        vHour >= 7 and vHour < 24 and
        pFame >= 1 and
        kenapaOvernight ~= 256
    then
        if kenapaOvernight == 0 then
            player:startEvent(336)
        elseif kenapaOvernight == 1 then
            player:startEvent(337)
        elseif kenapaOvernight == 2 then
            player:startEvent(338)
        elseif kenapaOvernight == 3 then
            player:startEvent(339) -- Actual quest acceptance Dialogue
        end
    elseif
        foodForThought == QUEST_COMPLETED and
        overnightDelivery == QUEST_AVAILABLE and
        kenapaOvernight == 256
    then
        if vHour > 6 and vHour < 7 then
            player:startEvent(347) -- Failed to return in time; dialogue before quest can be repeated
        else
            player:startEvent(336) -- Restart the quest from the beginning
        end
    elseif overnightDelivery == QUEST_ACCEPTED and not player:hasKeyItem(xi.ki.SMALL_BAG) then
        if kenapaOvernight == 4 then
            player:startEvent(340) -- Reminder for Overnight Delivery #1
        elseif kenapaOvernight == 5 then
            player:startEvent(341) -- Reminder for Overnight Delivery #2
        elseif kenapaOvernight == 6 then
            player:startEvent(342) -- Reminder for Overnight Delivery #3
        elseif kenapaOvernight == 7 then
            player:startEvent(343) -- Reminder for Overnight Delivery #4
        end
    elseif
        overnightDelivery == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.SMALL_BAG) and
        (vHour <= 6 or vHour >= 18)
    then
        local vDay = VanadielDayOfTheYear()

        if vDay == kenapaOvernightDay and (kenapaOvernightHour <= 24 or kenapaOvernightHour < 6) then
            player:startEvent(348) -- Brought the key item back inside the time frame; got the item and returned it on the same day
        elseif vDay == kenapaOvernightDay + 1 and kenapaOvernightHour <= 24 then
            player:startEvent(348) -- Brought the key item back inside the time frame
        else
            player:startEvent(346) -- Failed to return in time
        end
    elseif overnightDelivery == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.SMALL_BAG) and vHour > 6 then
        player:startEvent(346) -- Failed to return in time
    elseif overnightDelivery == QUEST_COMPLETED then
        if math.random(1, 2) == 1 then
            player:startEvent(349) -- Random comment after Overnight Delivery #1
        else
            player:startEvent(350) -- Random comment after Overnight Delivery #2
        end
    else
        if math.random(1, 2) == 1 then
            player:startEvent(302) -- Standard converstation
        else
            player:startEvent(303) -- Standard converstation
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 327 or csid == 330 or csid == 331 then
        player:confirmTrade()
        player:addGil(GIL_RATE * 120)
        if player:getCharVar("Kerutoto_Food_var") == 2 and player:getCharVar("Ohbiru_Food_var") == 3 then -- last NPC to be fed
            npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.FOOD_FOR_THOUGHT, {
                title = xi.title.FAST_FOOD_DELIVERER,
                fame = 100,
                var = {"Kerutoto_Food_var", "Kenapa_Food_var", "Ohbiru_Food_var"},
            })
            player:needToZone(true)
        else -- not the last NPC given food. flag this NPC as completed.
            player:setCharVar("Kenapa_Food_var", 4)
        end
    elseif csid == 318 then
        player:setCharVar("Kenapa_Food_var", 1)
    elseif csid == 319 then
        player:setCharVar("Kenapa_Food_var", 2)
    elseif csid == 320 then
        player:setCharVar("Kenapa_Food_var", 3)
    elseif csid == 56 then
        player:setCharVar("QuestHatInHand_var", utils.mask.setBit(player:getCharVar("QuestHatInHand_var"), 2, true))
        player:addCharVar("QuestHatInHand_count", 1)
    elseif csid == 336 then
        player:setCharVar("Kenapa_Overnight_var", 1)
    elseif csid == 337 then
        player:setCharVar("Kenapa_Overnight_var", 2)
    elseif csid == 338 then
        player:setCharVar("Kenapa_Overnight_var", 3)
    elseif csid == 339 then
        if option == 0 then
            player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.OVERNIGHT_DELIVERY)
            player:setCharVar("Kenapa_Overnight_var", 4)
        else
            player:setCharVar("Kenapa_Overnight_var", 0)
        end
    elseif csid == 340 then
        player:setCharVar("Kenapa_Overnight_var", 5)
    elseif csid == 341 then
        player:setCharVar("Kenapa_Overnight_var", 6)
    elseif csid == 342 then
        player:setCharVar("Kenapa_Overnight_var", 7)
    elseif csid == 343 then
        player:setCharVar("Kenapa_Overnight_var", 4) -- Begin reminder sequence
    elseif csid == 346 then
        player:delQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.OVERNIGHT_DELIVERY)
        player:delKeyItem(xi.ki.SMALL_BAG)
        player:setCharVar("Kenapa_Overnight_Hour_var", 0)
        player:setCharVar("Kenapa_Overnight_var", 256)
    elseif
        csid == 348 and
        npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.OVERNIGHT_DELIVERY, {
            item = 12590, -- power_gi
            fame = 100,
            var = {"Kenapa_Overnight_var", "Kenapa_Overnight_Hour_var"},
        })
    then
        player:delKeyItem(xi.ki.SMALL_BAG)
        player:needToZone(true)
    elseif csid == 519 then
        player:setCharVar("FLOWER_PROGRESS", 3)
    end
end

return entity
