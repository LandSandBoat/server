-----------------------------------
-- Area: Windurst Woods
--  NPC: Parih Vashai
-- Starts and Finishes Quest: The Fanged One, From Saplings Grow
-- !pos 117 -3 92 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- FIRE AND BRIMSTONE
    if player:getCharVar("fireAndBrimstone") == 5 and npcUtil.tradeHas(trade, 1113) then -- old earring
        player:startEvent(537, 0, 13360)
    end
end

entity.onTrigger = function(player, npc)
    local theFangedOne = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_FANGED_ONE) -- RNG flag quest
    local theFangedOneCS = player:getCharVar("TheFangedOne_Event")
    local sinHunting = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SIN_HUNTING)-- RNG AF1
    local sinHuntingCS = player:getCharVar("sinHunting")
    local fireAndBrimstone = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FIRE_AND_BRIMSTONE)-- RNG AF2
    local fireAndBrimstoneCS = player:getCharVar("fireAndBrimstone")
    local unbridledPassion = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.UNBRIDLED_PASSION)-- RNG AF3
    local unbridledPassionCS = player:getCharVar("unbridledPassion")
    local lvl = player:getMainLvl()
    local job = player:getMainJob()

    -- THREE PATHS
    if player:getCurrentMission(COP) == xi.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Louverance_s_Path") == 1 then
        player:startEvent(686)

    -- THE FANGED ONE
    elseif theFangedOne ~= QUEST_COMPLETED then
        if theFangedOne == QUEST_AVAILABLE and lvl >= ADVANCED_JOB_LEVEL then
            player:startEvent(351)
        elseif theFangedOne == QUEST_ACCEPTED and not player:hasKeyItem(xi.ki.OLD_TIGERS_FANG) then
            player:startEvent(352)
        elseif player:hasKeyItem(xi.ki.OLD_TIGERS_FANG) and theFangedOneCS ~= 1 then
            player:startEvent(357)
        elseif theFangedOneCS == 1 then
            player:startEvent(358)
        end

    -- SIN HUNTING
    elseif sinHunting == QUEST_AVAILABLE and job == xi.job.RNG and lvl >= AF1_QUEST_LEVEL and sinHuntingCS == 0 then
        player:startEvent(523) -- start RNG AF1
    elseif sinHuntingCS > 0 and sinHuntingCS < 5 then
        player:startEvent(524) -- during quest RNG AF1
    elseif sinHuntingCS == 5 then
        player:startEvent(527) -- complete quest RNG AF1

    -- FIRE AND BRIMSTONE
    elseif sinHunting == QUEST_COMPLETED and job == xi.job.RNG and lvl >= AF2_QUEST_LEVEL and fireAndBrimstone == QUEST_AVAILABLE and fireAndBrimstoneCS == 0 then
        player:startEvent(531) -- start RNG AF2
    elseif fireAndBrimstoneCS > 0 and fireAndBrimstoneCS < 4 then
        player:startEvent(532) -- during RNG AF2
    elseif fireAndBrimstoneCS == 4 then
        player:startEvent(535, 0, 13360, 1113) -- second part RNG AF2
    elseif fireAndBrimstoneCS == 5 then
        player:startEvent(536, 0, 13360, 1113) -- during second part RNG AF2

    -- UNBRIDLED PASSION
    elseif fireAndBrimstone == QUEST_COMPLETED and job == xi.job.RNG and lvl >= AF3_QUEST_LEVEL and unbridledPassion == QUEST_AVAILABLE and unbridledPassion == 0 then
        player:startEvent(541, 0, 13360) -- start RNG AF3
    elseif unbridledPassionCS > 0 and unbridledPassionCS < 3 then
        player:startEvent(542)-- during RNG AF3
    elseif unbridledPassionCS >= 3 and unbridledPassionCS < 7 then
        player:startEvent(542)-- during RNG AF3
    elseif unbridledPassionCS == 7 then
        player:startEvent(546, 0, 14099) -- complete RNG AF3

    -- STANDARD DIALOG
    else
        player:startEvent(338)
    end
end

entity.onEventFinish = function(player, csid, option)
    -- THREE PATHS
    if csid == 686 then
        player:setCharVar("COP_Louverance_s_Path", 2)

    -- THE FANGED ONE
    elseif csid == 351 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_FANGED_ONE)
        player:setCharVar("TheFangedOneCS", 1)
    elseif (csid == 357 or csid == 358) and npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.THE_FANGED_ONE, {item=13117, title=xi.title.THE_FANGED_ONE, var={"TheFangedOne_Event", "TheFangedOneCS"}}) then
        player:delKeyItem(xi.ki.OLD_TIGERS_FANG)
        player:unlockJob(xi.job.RNG)
        player:messageSpecial(ID.text.PERIH_VASHAI_DIALOG)

    -- SIN HUNTING
    elseif csid == 523 then -- start quest RNG AF1
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SIN_HUNTING)
        npcUtil.giveKeyItem(player, xi.ki.CHIEFTAINNESS_TWINSTONE_EARRING)
        player:setCharVar("sinHunting", 1)
    elseif csid == 527 and npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.SIN_HUNTING, {item=17188, var="sinHunting"}) then -- complete quest RNG AF1
        player:delKeyItem(xi.ki.CHIEFTAINNESS_TWINSTONE_EARRING)
        player:delKeyItem(xi.ki.PERCHONDS_ENVELOPE)

    -- FIRE AND BRIMSTONE
    elseif csid == 531 then -- start RNG AF2
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FIRE_AND_BRIMSTONE)
        player:setCharVar("fireAndBrimstone", 1)
    elseif csid == 535 then -- start second part RNG AF2
        player:setCharVar("fireAndBrimstone", 5)
    elseif csid == 537 and npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.FIRE_AND_BRIMSTONE, {item=12518, var="fireAndBrimstone"}) then -- complete quest RNG AF2
        player:confirmTrade()

    -- UNBRIDLED PASSION
    elseif csid == 541 then -- start RNG AF3
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.UNBRIDLED_PASSION)
        player:setCharVar("unbridledPassion", 1)
    elseif csid == 546 and npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.UNBRIDLED_PASSION, {item=14099, var="unbridledPassion"}) then -- complete quest RNG AF3
        player:delKeyItem(xi.ki.KOHS_LETTER)

    end
end

return entity
