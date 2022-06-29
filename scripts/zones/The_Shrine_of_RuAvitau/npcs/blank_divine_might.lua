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
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local currentZM = player:getCurrentMission(xi.mission.log_id.ZILART)
    local zmProgress = player:getMissionStatus(xi.mission.log_id.ZILART)
    local dmStatus = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT)
    local dmRepeat = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT)
    local aaKeyitems = 0
    local dmEarrings = 0
    local divineStatus = player:getCharVar("DivineMight")
    local moonOre = player:hasKeyItem(xi.ki.MOONLIGHT_ORE)

    -- Count keyitems
    for i=xi.ki.SHARD_OF_APATHY, xi.ki.SHARD_OF_RAGE do
        if (player:hasKeyItem(i) == true) then
            aaKeyitems = aaKeyitems + 1
        end
    end

    -- Count Earrings
    for i=14739, 14743 do
        if (player:hasItem(i) == true) then
            dmEarrings = dmEarrings + 1
        end
    end

    if (currentZM == xi.mission.id.zilart.ARK_ANGELS and zmProgress == 1 and divineStatus < 2) then -- Reminder CS/starts Divine Might (per Wiki)
        player:startEvent(54, 917, 1408, 1550)
    elseif (currentZM >= xi.mission.id.zilart.ARK_ANGELS and dmStatus == QUEST_AVAILABLE and aaKeyitems > 0) then -- Alternative cutscene for those that have done one or more AA fight
        player:startEvent(56, 917, 1408, 1550)
    elseif (dmStatus == QUEST_ACCEPTED and divineStatus >= 2) then -- CS when player has completed Divine might, award earring
        player:startEvent(55, 14739, 14740, 14741, 14742, 14743)
    elseif (dmStatus == QUEST_COMPLETED and dmEarrings < xi.settings.main.NUMBER_OF_DM_EARRINGS and dmRepeat ~= QUEST_ACCEPTED) then -- You threw away old Earring, start the repeat quest
        player:startEvent(57, player:getCharVar("DM_Earring"))
    elseif (dmRepeat == QUEST_ACCEPTED and divineStatus < 2) then
        if (moonOre == false) then
            player:startEvent(58) -- Reminder for Moonlight Ore
        else
            player:startEvent(56, 917, 1408, 1550) -- Reminder for Ark Pentasphere
        end
    elseif (dmRepeat == QUEST_ACCEPTED and divineStatus == 2 and moonOre == true) then -- Repeat turn in
        player:startEvent(59)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY) -- Need some kind of feedback
    end
end

entity.onEventUpdate = function(player, csid, option)
    if ((csid == 55 or csid == 59) and option == 2) then
        player:updateEvent(14739, 14740, 14741, 14742, 14743)
    end
end

entity.onEventFinish = function(player, csid, option)
    if ((csid == 54 or csid == 56) and player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT) == QUEST_AVAILABLE) then -- Flag Divine Might
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT)

    elseif (csid == 57) then -- Divine Might Repeat
        player:delQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT)
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT)

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
                    player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT)
                else
                    player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT)
                    player:delKeyItem(xi.ki.MOONLIGHT_ORE)
                end
                player:setCharVar("DivineMight", 0)
                player:setCharVar("DM_Earring", reward)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward)
            end
        end
    end
end

return entity
