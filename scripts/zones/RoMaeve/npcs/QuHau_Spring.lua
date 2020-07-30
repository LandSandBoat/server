-----------------------------------
-- Qu_Hau_Spring
-- Area: Ro'Maeve
-----------------------------------
local ID = require("scripts/zones/RoMaeve/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    local DMfirst = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.DIVINE_MIGHT)
    local DMRepeat = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.DIVINE_MIGHT_REPEAT)
    local Hour = VanadielHour()

    if ((Hour >= 18 or Hour < 6) and IsMoonFull() == true) then
        if (DMfirst == QUEST_ACCEPTED or DMRepeat == QUEST_ACCEPTED) then -- allow for Ark Pentasphere on both first and repeat quests
            if (trade:hasItemQty(1408, 1) and trade:hasItemQty(917, 1) and trade:getItemCount() == 2) then
                player:startEvent(7, 917, 1408) -- Ark Pentasphere Trade
            elseif (DMRepeat == QUEST_ACCEPTED and trade:hasItemQty(1261, 1) and trade:getItemCount() == 1 and player:hasKeyItem(tpz.ki.MOONLIGHT_ORE) == false) then
                player:startEvent(8) -- Moonlight Ore trade
            end
        end
    end
end

function onTrigger(player, npc)
    local CurrentMission = player:getCurrentMission(WINDURST)
    local MissionStatus = player:getCharVar("MissionStatus")

    if (CurrentMission == tpz.mission.id.windurst.VAIN and MissionStatus >= 1) then
        player:startEvent(2)
    elseif (CurrentMission == tpz.mission.id.windurst.MOON_READING and MissionStatus >= 1) then
        player:startEvent(4)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 7) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1550)
        else
            player:addItem(1550)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1550)
            player:tradeComplete()
        end
    elseif (csid == 8) then
        player:tradeComplete()
        player:addKeyItem(tpz.ki.MOONLIGHT_ORE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MOONLIGHT_ORE)
    elseif (csid == 2 and player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN) then
        player:setCharVar("MissionStatus", 2)
    elseif (csid == 4 and player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.MOON_READING) then
        player:addKeyItem(tpz.ki.ANCIENT_VERSE_OF_ROMAEVE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ANCIENT_VERSE_OF_ROMAEVE)
    end
end
