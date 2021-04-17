-----------------------------------
-- Area: Windurst Waters
--  NPC: Kerutoto
-- Starts Quest Food For Thought
-- Involved in Quest: Riding on the Clouds
-- !pos 13 -5 -157 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local blueRibbonBlues = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLUE_RIBBON_BLUES)

    -- BLUE RIBBON BLUES
    if blueRibbonBlues == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 12521) then -- blue_ribbon
        player:startEvent(362)
    elseif blueRibbonBlues == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 13569) then -- purple_ribbon
        if player:getCharVar("BlueRibbonBluesProg") == 4 then
            player:startEvent(365) -- Lost, ribbon but it came back
        else
            player:startEvent(358, 3600)
        end

    -- FOOD FOR THOUGHT
    elseif
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FOOD_FOR_THOUGHT) == QUEST_ACCEPTED and
        player:getCharVar("Kerutoto_Food_var") == 1 and
        npcUtil.tradeHas(trade, 4371) -- slice_of_grilled_hare
    then
        player:startEvent(332, 440)

    -- RIDING ON THE CLOUDS
    elseif
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and
        player:getCharVar("ridingOnTheClouds_4") == 3 and
        npcUtil.tradeHas(trade, 1127) -- kindreds_seal
    then
        player:setCharVar("ridingOnTheClouds_4", 0)
        player:confirmTrade()
        npcUtil.giveKeyItem(player, xi.ki.SPIRITED_STONE)
    end
end

entity.onTrigger = function(player, npc)
    local windurstMission = player:getCurrentMission(WINDURST)
    local windurstStatus = player:getMissionStatus(player:getNation())
    local blueRibbonBlues = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLUE_RIBBON_BLUES)
    local wakingDreams = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WAKING_DREAMS)
    local foodForThought = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FOOD_FOR_THOUGHT)
    local kerutotoFood = player:getCharVar("Kerutoto_Food_var")
    local ohbiruFood = player:getCharVar("Ohbiru_Food_var")
    local needZone = player:needToZone()

    -- Awakening of the Gods
    if (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getMissionStatus(player:getNation()) == 0) then
        player:startEvent(737)
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getMissionStatus(player:getNation()) == 1) then
        player:startEvent(736)
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getMissionStatus(player:getNation()) == 2) then
        player:startEvent(738)

    -- THREE PATHS (ULMIA)
    elseif player:getCurrentMission(COP) == xi.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Ulmia_s_Path") == 3 then
        player:startEvent(876)

    -- WAKING DREAMS
    elseif
        not player:hasKeyItem(xi.ki.VIAL_OF_DREAM_INCENSE) and
        (
            player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) and
            wakingDreams == QUEST_AVAILABLE
        ) or
        (
            wakingDreams == QUEST_COMPLETED and
            os.time() > player:getCharVar("Darkness_Named_date")
        )
    then
        player:startEvent(918)
    elseif player:hasKeyItem(xi.ki.WHISPER_OF_DREAMS) then
        local availRewards = 0
            + (player:hasItem(17599) and 1 or 0) -- Diabolos's Pole
            + (player:hasItem(14814) and 2 or 0) -- Diabolos's Earring
            + (player:hasItem(15557) and 4 or 0) -- Diabolos's Ring
            + (player:hasItem(15516) and 8 or 0) -- Diabolos's Torque
            + (player:hasSpell(304) and 32 or 16) -- Pact or gil
        player:startEvent(920, 17599, 14814, 15557, 15516, 0, 0, 0, availRewards)

    -- BLUE RIBBON BLUES
    elseif blueRibbonBlues == QUEST_COMPLETED and needZone then
        player:startEvent(363)
    elseif blueRibbonBlues == QUEST_ACCEPTED then
        local blueRibbonProg = player:getCharVar("BlueRibbonBluesProg")

        if player:hasItem(12521) then
            player:startEvent(362)
        elseif blueRibbonProg == 2 and not needZone then
            player:startEvent(360) -- go to the grave
        elseif blueRibbonProg == 2 then
            player:startEvent(359) -- Thanks for the ribbon
        elseif blueRibbonProg == 3 then
            if player:hasItem(13569) then
                player:startEvent(361, 0, 13569) -- reminder, go to the grave
            else
                player:startEvent(366, 0, 13569) -- lost the ribbon
            end
        elseif blueRibbonProg == 4 then
            player:startEvent(366, 0, 13569)
        else
            player:startEvent(306) -- Standard Conversation
        end
    elseif
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WATER_WAY_TO_GO) == QUEST_COMPLETED and
        blueRibbonBlues == QUEST_AVAILABLE and
        player:getFameLevel(WINDURST) >= 5
    then
        player:startEvent(357)

    -- FOOD FOR THOUGHT
    elseif foodForThought == QUEST_AVAILABLE then
        if ohbiruFood == 1 and kerutotoFood ~= 256 then -- Player knows the researchers are hungry and quest not refused
            player:startEvent(313, 0, 4371) -- Offered Quest 1 (Including Order ifYES)
        elseif ohbiruFood == 1 and kerutotoFood == 256 then -- Player knows the researchers are hungry and quest refused previously
            player:startEvent(314, 0, 4371) -- Offered Quest 2 (Including Order ifYES)
        else
            player:startEvent(312) -- Before Quest: Asks you to check on others.
        end
    elseif foodForThought == QUEST_ACCEPTED then
        if kerutotoFood == 1 then
            player:startEvent(315, 0, 4371) -- Repeats Order
        elseif kerutotoFood == 2 then
            player:startEvent(333) -- Reminder to check with the others if this NPC has already been fed
        end
    elseif foodForThought == QUEST_COMPLETED and needZone then
        player:startEvent(304) -- NPC is sleeping but feels full (post Food for Thought)

    -- DEFAULT DIALOG
    else
        player:startEvent(306)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- THREE PATHS
    if csid == 876 then
        player:setCharVar("COP_Ulmia_s_Path", 4)

    -- FOOD FOR THOUGHT
    elseif (csid == 313 and option == 0) or (csid == 314 and option == 0) then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FOOD_FOR_THOUGHT)
        player:setCharVar("Kerutoto_Food_var", 1)
    elseif csid == 313 and option == 1 then
        player:setCharVar("Kerutoto_Food_var", 256)
    elseif csid == 332 then
        player:confirmTrade()
        player:addGil(GIL_RATE * 440)

        -- last NPC to be given food
        if player:getCharVar("Kenapa_Food_var") == 4 and player:getCharVar("Ohbiru_Food_var") == 3 then
            npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.FOOD_FOR_THOUGHT, {
                title = xi.title.FAST_FOOD_DELIVERER,
                fame = 100,
                var = {"Kerutoto_Food_var", "Kenapa_Food_var", "Ohbiru_Food_var"},
            })
            player:needToZone(true)

        -- not last NPC given food. flag this NPC as completed.
        else
            player:setCharVar("Kerutoto_Food_var", 2)
        end

    -- BLUE RIBBON BLUES
    elseif csid == 357 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLUE_RIBBON_BLUES)
    elseif csid == 358 or csid == 365 then
        player:confirmTrade()
        player:setCharVar("BlueRibbonBluesProg", 2)
        player:needToZone(true)
        if csid == 358 then
            player:addGil(GIL_RATE * 3600)
        end
    elseif csid == 360 and npcUtil.giveItem(player, 13569) then
        player:setCharVar("BlueRibbonBluesProg", 3)
    elseif csid == 362 then
        npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.BLUE_RIBBON_BLUES, {
            title = xi.title.GHOSTIE_BUSTER,
            fame = 140,
            var = "BlueRibbonBluesProg",
        })
        player:needToZone(true)

    -- WAKING DREAMS
    elseif csid == 918 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WAKING_DREAMS)
        npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_DREAM_INCENSE)
    elseif csid == 920 then
        local reward = {fame = 0}

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

        if npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.WAKING_DREAMS, reward) then
            player:delKeyItem(xi.ki.WHISPER_OF_DREAMS)
            player:setCharVar("Darkness_Named_date", getMidnight())
        end
    -- AWAKENING OF THE GODS
    elseif csid == 736 then
        player:setMissionStatus(player:getNation(), 2)
    end
end

return entity
