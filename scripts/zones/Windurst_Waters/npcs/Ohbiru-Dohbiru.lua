-----------------------------------
-- Area: Windurst Waters
--  NPC: Ohbiru-Dohbiru
-- Involved in quest: Food For Thought, Say It with Flowers
--  Starts and finishes quest: Toraimarai Turmoil
-- !pos 23 -5 -193 238
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/titles")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local turmoil = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)
    local count = trade:getItemCount()

    if turmoil == QUEST_ACCEPTED then
        if count == 3 and trade:getGil() == 0 and trade:hasItemQty(906, 3) then --Check that all 3 items have been traded
            player:startEvent(791)
        else
            player:startEvent(786, 4500, 267, 906) -- Reminder of needed items
        end
    elseif turmoil == QUEST_COMPLETED then
        if count == 3 and trade:getGil() == 0 and trade:hasItemQty(906, 3) then --Check that all 3 items have been traded
            player:startEvent(791)
        else
            player:startEvent(795, 4500, 0, 906) -- Reminder of needed items for repeated quest
        end
    end
end

entity.onTrigger = function(player, npc)
    local pfame = player:getFameLevel(xi.quest.fame_area.WINDURST)
    local turmoil = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)
    local needToZone = player:needToZone()
    local sayFlowers = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)
    local flowerProgress = player:getCharVar("FLOWER_PROGRESS")
    local blueRibbonBlues = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLUE_RIBBON_BLUES)

    if
        (sayFlowers == QUEST_ACCEPTED or sayFlowers == QUEST_COMPLETED) and
        flowerProgress == 1
    then
        if needToZone then
            player:startEvent(518)
        elseif player:getCharVar("FLOWER_PROGRESS") == 2 then
            player:startEvent(517, 0, 0, 0, 0, 950)
        else
            player:startEvent(516, 0, 0, 0, 0, 950)
        end

    -- Begin Toraimarai Turmoil Section
    elseif
        blueRibbonBlues == QUEST_COMPLETED and
        turmoil == QUEST_AVAILABLE and
        pfame >= 6 and
        not needToZone
    then
        player:startEvent(785, 4500, 267, 906)
    elseif turmoil == QUEST_ACCEPTED then
        player:startEvent(786, 4500, 267, 906) -- Reminder of needed items
    elseif turmoil == QUEST_COMPLETED then
        player:startEvent(795, 4500, 0, 906) -- Allows player to initiate repeat of Toraimarai Turmoil
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local flowerList =
    {
        [0] = { itemid = 948, gil = 300 }, -- Carnation
        [1] = { itemid = 941, gil = 200 }, -- Red Rose
        [2] = { itemid = 949, gil = 250 }, -- Rain Lily
        [3] = { itemid = 956, gil = 150 }, -- Lilac
        [4] = { itemid = 957, gil = 200 }, -- Amaryllis
        [5] = { itemid = 958, gil = 100 }  -- Marguerite
    }

    -- Check Missions first (priority?)
    local turmoil = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)

    if csid == 785 and option == 1 then -- Adds Toraimarai turmoil
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.RHINOSTERY_CERTIFICATE)
        player:addKeyItem(xi.ki.RHINOSTERY_CERTIFICATE) -- Rhinostery Certificate
    elseif csid == 791 and turmoil == QUEST_ACCEPTED then -- Completes Toraimarai turmoil - first time
        npcUtil.giveCurrency(player, 'gil', 4500)
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)
        player:addFame(xi.quest.fame_area.WINDURST, 100)
        player:addTitle(xi.title.CERTIFIED_RHINOSTERY_VENTURER)
        player:tradeComplete()
    elseif csid == 791 and turmoil == 2 then -- Completes Toraimarai turmoil - repeats
        npcUtil.giveCurrency(player, 'gil', 4500)
        player:addFame(xi.quest.fame_area.WINDURST, 50)
        player:tradeComplete()
    elseif csid == 516 then
        if option < 7 then
            local choice = flowerList[option]
            if choice and player:getGil() >= choice.gil then
                if player:getFreeSlotsCount() > 0 then
                    player:addItem(choice.itemid)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, choice.itemid)
                    player:delGil(choice.gil)
                    player:needToZone(true)
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, choice.itemid)
                end
            else
                player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
            end
        elseif option == 7 then
            player:setCharVar("FLOWER_PROGRESS", 2)
        end
    end
end

return entity
