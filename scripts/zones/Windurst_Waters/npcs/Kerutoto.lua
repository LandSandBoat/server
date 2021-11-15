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
require("scripts/settings/main")
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
    end
end

entity.onTrigger = function(player, npc)
    local blueRibbonBlues = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLUE_RIBBON_BLUES)
    local wakingDreams = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WAKING_DREAMS)
    local needZone = player:needToZone()

    -- THREE PATHS (ULMIA)
    if player:getCurrentMission(COP) == xi.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Ulmia_s_Path") == 3 then
        player:startEvent(876)

    -- WAKING DREAMS
    elseif player:hasKeyItem(xi.ki.WHISPER_OF_DREAMS) then
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
        ) or
        (
            wakingDreams == QUEST_COMPLETED and
            os.time() > player:getCharVar("Darkness_Named_date")
        )
    then
        player:startEvent(918)

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
        end
    elseif
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WATER_WAY_TO_GO) == QUEST_COMPLETED and
        blueRibbonBlues == QUEST_AVAILABLE and
        player:getFameLevel(WINDURST) >= 5
    then
        player:startEvent(357)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- THREE PATHS
    if csid == 876 then
        player:setCharVar("COP_Ulmia_s_Path", 4)

    -- BLUE RIBBON BLUES
    elseif csid == 357 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLUE_RIBBON_BLUES)
    elseif csid == 358 or csid == 365 then
        player:confirmTrade()
        player:setCharVar("BlueRibbonBluesProg", 2)
        player:needToZone(true)
        if csid == 358 then
            player:addGil(xi.settings.GIL_RATE * 3600)
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
    end
end

return entity
