-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: Blue Rafflesia
-- Used in quest Even More Gullible Travels
-- !pos -468.876 -1 220.247 123 <many>
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local evenmoreTravelsStatus = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.EVEN_MORE_GULLIBLES_TRAVELS)
    local questprogress = player:getCharVar("EVEN_MORE_GULLIBLES_PROGRESS")
    local scentDay = player:getCharVar("RafflesiaScentDay")
    local currentDay = VanadielDayOfTheYear()
    local scentReady = (scentDay < currentDay) or (scentDay > currentDay and player:getCharVar("RafflesiaScentYear") < VanadielYear())
    local offset = npc:getID() - ID.npc.BLUE_RAFFLESIA_OFFSET

    if offset == 0 then
        if evenmoreTravelsStatus == QUEST_ACCEPTED and questprogress == 1 and player:getCharVar("FirstBlueRafflesiaCS") == 0 then -- Player is on quest, first time.
            player:startEvent(21)
        elseif evenmoreTravelsStatus == QUEST_COMPLETED and scentReady and player:getCharVar("BathedInScent") == 0 and player:getCharVar("FirstBlueRafflesiaCS") == 0 then -- Repeating
            player:startEvent(21)
        else
            player:messageSpecial(ID.text.FLOWER_BLOOMING)
        end
    elseif offset == 1 then
        if evenmoreTravelsStatus == QUEST_ACCEPTED and questprogress == 1 and player:getCharVar("SecondBlueRafflesiaCS") == 0 then
            player:startEvent(22)
        elseif evenmoreTravelsStatus == QUEST_COMPLETED and scentReady and player:getCharVar("BathedInScent") == 0 and player:getCharVar("SecondBlueRafflesiaCS") == 0 then
            player:startEvent(22)
        else
            player:messageSpecial(ID.text.FLOWER_BLOOMING)
        end
    elseif offset == 2 then
        if evenmoreTravelsStatus == QUEST_ACCEPTED and questprogress == 1 and player:getCharVar("ThirdBlueRafflesiaCS") == 0 then
            player:startEvent(23)
        elseif evenmoreTravelsStatus == QUEST_COMPLETED and scentReady and player:getCharVar("BathedInScent") == 0 and player:getCharVar("ThirdBlueRafflesiaCS") == 0 then
            player:startEvent(23)
        else
            player:messageSpecial(ID.text.FLOWER_BLOOMING)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local evenmoreTravelsStatus = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.EVEN_MORE_GULLIBLES_TRAVELS)

    -- Set BathedInScent to 1 if they touched all 3 Rafflesia for EVEN_MORE_GULLIBLES_TRAVELS which opens the quest The Opo-Opo and I
    if csid == 21 and option == 1 then
        if player:getCharVar("SecondBlueRafflesiaCS") == 1 and player:getCharVar("ThirdBlueRafflesiaCS") == 1 then -- This is 3rd Rafflessia clicked, progressing.
            player:setCharVar("SecondBlueRafflesiaCS", 0)
            player:setCharVar("ThirdBlueRafflesiaCS", 0)
            player:setCharVar("BathedInScent", 1)
            player:setCharVar("RafflesiaScentDay", VanadielDayOfTheYear())
            player:setCharVar("RafflesiaScentYear", VanadielYear())
            player:addItem(1144)        -- Rafflesia Nectar
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1144)
            player:messageSpecial(ID.text.FEEL_DIZZY) -- You feel slightly dizzy. You must have breathed in too much of the pollen.
            if evenmoreTravelsStatus == QUEST_ACCEPTED then
                player:setCharVar("EVEN_MORE_GULLIBLES_PROGRESS", 2)
            end
        else
            player:setCharVar("FirstBlueRafflesiaCS", 1)
            player:addItem(1144)        -- Rafflesia Nectar
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1144)
        end
    elseif csid == 22 and option == 1 then
        if player:getCharVar("FirstBlueRafflesiaCS") == 1 and player:getCharVar("ThirdBlueRafflesiaCS") == 1 then
            player:setCharVar("FirstBlueRafflesiaCS", 0)
            player:setCharVar("ThirdBlueRafflesiaCS", 0)
            player:setCharVar("BathedInScent", 1)
            player:setCharVar("RafflesiaScentDay", VanadielDayOfTheYear())
            player:setCharVar("RafflesiaScentYear", VanadielYear())
            player:addItem(1144)        -- Rafflesia Nectar
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1144)
            player:messageSpecial(ID.text.FEEL_DIZZY) -- You feel slightly dizzy. You must have breathed in too much of the pollen.
            if evenmoreTravelsStatus == QUEST_ACCEPTED then
                player:setCharVar("EVEN_MORE_GULLIBLES_PROGRESS", 2)
            end
        else
            player:setCharVar("SecondBlueRafflesiaCS", 1)
            player:addItem(1144)        -- Rafflesia Nectar
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1144)
        end
    elseif csid == 23 and option == 1 then
        if player:getCharVar("FirstBlueRafflesiaCS") == 1 and player:getCharVar("SecondBlueRafflesiaCS") == 1 then
            player:setCharVar("FirstBlueRafflesiaCS", 0)
            player:setCharVar("SecondBlueRafflesiaCS", 0)
            player:setCharVar("BathedInScent", 1)
            player:setCharVar("RafflesiaScentDay", VanadielDayOfTheYear())
            player:setCharVar("RafflesiaScentYear", VanadielYear())
            player:addItem(1144)        -- Rafflesia Nectar
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1144)
            player:messageSpecial(ID.text.FEEL_DIZZY) -- You feel slightly dizzy. You must have breathed in too much of the pollen.
            if evenmoreTravelsStatus == QUEST_ACCEPTED then
                player:setCharVar("EVEN_MORE_GULLIBLES_PROGRESS", 2)
            end
        else
            player:setCharVar("ThirdBlueRafflesiaCS", 1)
            player:addItem(1144)        -- Rafflesia Nectar
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1144)
        end
    end
end
