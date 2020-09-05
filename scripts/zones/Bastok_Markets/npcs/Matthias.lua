-----------------------------------
-- Area: Bastok Markets
--  NPC: Matthias
-- Standard Info NPC
-- Involved in Quest:
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/quests")
-----------------------------------

--local variables for item IDs to make things clearer
local imperialSilk = 2340
local wolfFelt = 2010
local silverBrocade = 1991

local karakulCloth = 2288
local rainbowCloth = 830
local rainbowVelvet = 1996

local wamouraCloth = 2289
local moblinWeave = 1636
local goldBrocade = 1999

function onTrade(player, npc, trade)

    if (player:getCharVar("dancerTailorCS") == 4) then
        local playersAFChoice = player:getCharVar("dancerAFChoice")

        if (playersAFChoice == 1 and
            trade:hasItemQty(imperialSilk, 1) == true and
            trade:hasItemQty(wolfFelt, 1) == true and
            trade:hasItemQty(silverBrocade, 1) == true and
            trade:getItemCount() == 3 and
            trade:getGil() == 0) then

            rewardThePlayer(player)

        elseif (playersAFChoice == 2 and
            trade:hasItemQty(karakulCloth, 1) == true and
            trade:hasItemQty(rainbowCloth, 1) == true and
            trade:hasItemQty(rainbowVelvet, 1) == true and
            trade:getItemCount() == 3 and
            trade:getGil() == 0) then

            rewardThePlayer(player)

        elseif (playersAFChoice == 3 and
            trade:hasItemQty(wamouraCloth, 1) == true and
            trade:hasItemQty(moblinWeave, 1) == true and
            trade:hasItemQty(goldBrocade, 1) == true and
            trade:getItemCount() == 3 and
            trade:getGil() == 0) then

            rewardThePlayer(player)
        end
    end
end

function rewardThePlayer(player)
    local playersAFChoice = player:getCharVar("dancerAFChoice")
    local currentVanaDay = VanadielDayOfTheYear()
    player:setCharVar("dancerTailorWorkDay", currentVanaDay)
    player:setCharVar("dancerTailorCS", 5)
    player:tradeComplete()
    player:startEvent(495, playersAFChoice-1)
end

-- local variables for item IDs to make things clearer
local dancersTiara = 16139
local dancersBangles = 15003
local dancersToeshoes = 15747

function onTrigger(player, npc)

    local playersAFChoice = player:getCharVar("dancerAFChoice")
    local tailorStartedWorkDay = player:getCharVar("dancerTailorWorkDay")

    if (player:getCharVar("dancerTailorCS") == 2) then
        player:startEvent(492)
    elseif (player:getCharVar("dancerTailorCS") == 3) then

        local completedPieces = player:getCharVar("dancerCompletedAF")

        local playerCompletedTiara = 0
        if (bit.band(completedPieces, 1) > 0) then
            playerCompletedTiara = 1
        end

        local playerCompletedBangles = 0
        if (bit.band(completedPieces, 2) > 0) then
            playerCompletedBangles = 1
        end

        local playerCompletedShoes = 0
        if (bit.band(completedPieces, 4) > 0) then
            playerCompletedShoes = 1
        end

        local completedPieces = playerCompletedShoes + playerCompletedBangles + playerCompletedTiara
        if (completedPieces == 3) then
            player:setCharVar("dancerTailorCS", 6)
            player:startEvent(498)
        else
            player:startEvent(493, playerCompletedTiara, playerCompletedBangles, playerCompletedShoes)
        end

    elseif (player:getCharVar("dancerTailorCS") == 4) then

        player:startEvent(494, playersAFChoice -1) -- event params indexed from 0

    elseif (player:getCharVar("dancerTailorCS") == 5 )then

        local currentVanaDay = VanadielDayOfTheYear()

        if (currentVanaDay > tailorStartedWorkDay) then

            local dancerAFID = 1 -- variable used to convert player's choice into an Item ID.
            local playerGender = player:getGender() --gender is actually important here because it displays the item on screen for you.

            if (playersAFChoice == 1) then
                dancerAFID = dancersTiara - playerGender
            elseif (playersAFChoice == 2) then
                dancerAFID = dancersBangles - playerGender
            elseif (playersAFChoice == 3) then
                dancerAFID = dancersToeshoes - playerGender
            end

            player:startEvent(497, dancerAFID)

        else
            player:startEvent(496) -- not enough time has passed
        end
    elseif (player:getCharVar("dancerTailorCS") == 6) then
        player:startEvent(498)
    else
        player:startEvent(499)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    local completedPieces = player:getCharVar("dancerCompletedAF")

    if (csid == 492) then

        if (option > 0) then -- option 1 - tiara 2 - bangles 3 - shoes
            player:setCharVar("dancerAFChoice", option)
            player:setCharVar("dancerTailorCS", 4)
        else
            player:setCharVar("dancerTailorCS", 3)
        end

    elseif (csid == 493) then

        if (option > 0) then -- option 1 - tiara 2 - bangles 3 - shoes

            local choiceBit = bit.lshift(1, option - 1) --check to see if the player already did this piece

            if (bit.band(choiceBit, completedPieces) == choiceBit) then
                player:startEvent(498)

            else
                player:setCharVar("dancerAFChoice", option)
                player:setCharVar("dancerTailorCS", 4)
            end
        end

    elseif (csid == 497) then -- reward player the appropriate AF

        local dancerAFID = 1 -- variable used to convert player's choice into an Item ID.
        local playersAFChoice = player:getCharVar("dancerAFChoice")

        if (playersAFChoice == 1) then
            dancerAFID = dancersTiara
        elseif (playersAFChoice == 2) then
            dancerAFID = dancersBangles
        elseif (playersAFChoice == 3) then
            dancerAFID = dancersToeshoes
        end

        if (player:getFreeSlotsCount() == 0) then --check to see if the player has enough inventory space before rewarding them.
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, dancerAFID)
        else
            local playerGender = player:getGender()
            player:addItem(dancerAFID - playerGender)
            player:messageSpecial(ID.text.ITEM_OBTAINED, dancerAFID)

            local allPiecesCompleted = 7
            if (bit.band(completedPieces, allPiecesCompleted) == allPiecesCompleted) then
                player:setCharVar("dancerTailorCS", 6) -- final cs flag
            else
                local playersReward = bit.lshift(1, playersAFChoice - 1)
                completedPieces = bit.bor(completedPieces, playersReward)
                player:setCharVar("dancerCompletedAF", completedPieces)
                player:setCharVar("dancerTailorCS", 3)
            end
        end
    else
    -- do nothing
    end
end
