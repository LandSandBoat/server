-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  NPC: ??? divine might mission
-- !pos -40 0 -151 178
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local CurrentZM = player:getCurrentMission(ZILART)
    local ZMProgress = player:getCharVar("ZilartStatus")
    local DMStatus = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.DIVINE_MIGHT)
    local DMRepeat = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.DIVINE_MIGHT_REPEAT)
    local AAKeyitems = 0
    local DMEarrings = 0
    local DivineStatus = player:getCharVar("DivineMight")
    local MoonOre = player:hasKeyItem(tpz.ki.MOONLIGHT_ORE)

    -- Count keyitems
    for i=tpz.ki.SHARD_OF_APATHY, tpz.ki.SHARD_OF_RAGE do
        if (player:hasKeyItem(i) == true) then
            AAKeyitems = AAKeyitems + 1
        end
    end

    -- Count Earrings
    for i=14739, 14743 do
        if (player:hasItem(i) == true) then
            DMEarrings = DMEarrings + 1
        end
    end

    if (CurrentZM == tpz.mission.id.zilart.ARK_ANGELS and ZMProgress == 0 and DMEarrings <= NUMBER_OF_DM_EARRINGS) then -- First step in Ark Angels
        player:startEvent(53, 917, 1408, 1550)
    elseif (CurrentZM == tpz.mission.id.zilart.ARK_ANGELS and ZMProgress == 1 and DivineStatus < 2) then -- Reminder CS/starts Divine Might (per Wiki)
        player:startEvent(54, 917, 1408, 1550)
    elseif (CurrentZM >= tpz.mission.id.zilart.ARK_ANGELS and DMStatus == QUEST_AVAILABLE and AAKeyitems > 0) then -- Alternative cutscene for those that have done one or more AA fight
        player:startEvent(56, 917, 1408, 1550)
    elseif (DMStatus == QUEST_ACCEPTED and DivineStatus >= 2) then -- CS when player has completed Divine might, award earring
        player:startEvent(55, 14739, 14740, 14741, 14742, 14743)
    elseif (DMStatus == QUEST_COMPLETED and DMEarrings < NUMBER_OF_DM_EARRINGS and DMRepeat ~= QUEST_ACCEPTED) then -- You threw away old Earring, start the repeat quest
        player:startEvent(57, player:getCharVar("DM_Earring"))
    elseif (DMRepeat == QUEST_ACCEPTED and DivineStatus < 2) then
        if (MoonOre == false) then
            player:startEvent(58) -- Reminder for Moonlight Ore
        else
            player:startEvent(56, 917, 1408, 1550) -- Reminder for Ark Pentasphere
        end
    elseif (DMRepeat == QUEST_ACCEPTED and DivineStatus == 2 and MoonOre == true) then -- Repeat turn in
        player:startEvent(59)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY) -- Need some kind of feedback
    end

end

function onEventUpdate(player, csid, option)
    if ((csid == 55 or csid == 59) and option == 2) then
        player:updateEvent(14739, 14740, 14741, 14742, 14743)
    end
end

function onEventFinish(player, csid, option)

    if (csid == 53) then -- Got the required cutscene for AA
        player:setCharVar("ZilartStatus", 1)

    elseif ((csid == 54 or csid == 56) and player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.DIVINE_MIGHT) == QUEST_AVAILABLE) then -- Flag Divine Might
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.DIVINE_MIGHT)

    elseif (csid == 57) then -- Divine Might Repeat
        player:delQuest(OUTLANDS, tpz.quest.id.outlands.DIVINE_MIGHT_REPEAT)
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.DIVINE_MIGHT_REPEAT)

    elseif (csid == 55 or csid == 59) then -- Turning in Divine Might or Repeat
        local reward = 0
        if (option == 1) then
            reward = 14739 -- Suppanomimi
        elseif (option == 2) then
            reward = 14740 -- Knight's Earring
        elseif (option == 3) then
            reward = 14741 -- Abyssal Earring
        elseif (option == 4) then
            reward = 14742 -- Beastly Earring
        elseif (option == 5) then
            reward = 14743 -- Bushinomimi
        end
        if (reward ~= 0) then
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(reward) == false) then
                player:addItem(reward)
                player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
                if (csid == 55) then
                    player:completeQuest(OUTLANDS, tpz.quest.id.outlands.DIVINE_MIGHT)
                else
                    player:completeQuest(OUTLANDS, tpz.quest.id.outlands.DIVINE_MIGHT_REPEAT)
                    player:delKeyItem(tpz.ki.MOONLIGHT_ORE)
                end
                player:setCharVar("DivineMight", 0)
                player:setCharVar("DM_Earring", reward)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward)
            end
        end
    end
end
