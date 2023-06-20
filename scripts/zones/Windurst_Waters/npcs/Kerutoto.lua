-----------------------------------
-- Area: Windurst Waters
--  NPC: Kerutoto
-- Starts Quest Food For Thought
-- Involved in Quest: Riding on the Clouds
-- !pos 13 -5 -157 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local wakingDreams = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WAKING_DREAMS)

    -- WAKING DREAMS
    if player:hasKeyItem(xi.ki.WHISPER_OF_DREAMS) then
        local availRewards = 0
            + (player:hasItem(17599) and 1 or 0) -- Diabolos's Pole
            + (player:hasItem(14814) and 2 or 0) -- Diabolos's Earring
            + (player:hasItem(15557) and 4 or 0) -- Diabolos's Ring
            + (player:hasItem(15516) and 8 or 0) -- Diabolos's Torque
            + (player:hasSpell(304) and 32 or 16) -- Pact or gil
        player:startEvent(920, 17599, 14814, 15557, 15516, 0, 0, 0, availRewards)
    elseif
        not player:hasKeyItem(xi.ki.VIAL_OF_DREAM_INCENSE) and
        (
            player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) and
            wakingDreams == QUEST_AVAILABLE
        )
        or
        (
            wakingDreams == QUEST_COMPLETED and
            os.time() > player:getCharVar("Darkness_Named_date")
        )
    then
        player:startEvent(918)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- WAKING DREAMS
    if csid == 918 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WAKING_DREAMS)
        npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_DREAM_INCENSE)
    elseif csid == 920 then
        local reward = { fame = 0 }

        if option == 1 and not player:hasItem(17599) then
            reward.item = 17599
        elseif option == 2 and not player:hasItem(14814) then
            reward.item = 14814
        elseif option == 3 and not player:hasItem(15557) then
            reward.item = 15557
        elseif option == 4 and not player:hasItem(15516) then
            reward.item = 15516
        elseif option == 5 then
            reward.gil = 15000
        elseif option == 6 and not player:hasSpell(304) then
            player:addSpell(304)
            player:messageSpecial(ID.text.DIABOLOS_UNLOCKED, 0, 0, 0)
        end

        if npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.WAKING_DREAMS, reward) then
            player:delKeyItem(xi.ki.WHISPER_OF_DREAMS)
            player:setCharVar("Darkness_Named_date", getMidnight())
        end
    end
end

return entity
