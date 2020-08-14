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
require("scripts/globals/wsquest")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

local wsQuest = tpz.wsquest.empyreal_arrow

function onTrade(player, npc, trade)
    local wsQuestEvent = tpz.wsquest.getTradeEvent(wsQuest, player, trade)

    -- FROM SAPLINGS GROW
    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)

    -- FIRE AND BRIMSTONE
    elseif player:getCharVar("fireAndBrimstone") == 5 and npcUtil.tradeHas(trade, 1113) then -- old earring
        player:startEvent(537, 0, 13360)
    end
end

function onTrigger(player, npc)
    local wsQuestEvent = tpz.wsquest.getTriggerEvent(wsQuest, player)
    local theFangedOne = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_FANGED_ONE) -- RNG flag quest
    local theFangedOneCS = player:getCharVar("TheFangedOne_Event")
    local sinHunting = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.SIN_HUNTING)-- RNG AF1
    local sinHuntingCS = player:getCharVar("sinHunting")
    local fireAndBrimstone = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.FIRE_AND_BRIMSTONE)-- RNG AF2
    local fireAndBrimstoneCS = player:getCharVar("fireAndBrimstone")
    local unbridledPassion = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.UNBRIDLED_PASSION)-- RNG AF3
    local unbridledPassionCS = player:getCharVar("unbridledPassion")
    local lvl = player:getMainLvl()
    local job = player:getMainJob()

    -- FROM SAPLINGS GROW
    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)

    -- THREE PATHS
    elseif player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Louverance_s_Path") == 1 then
        player:startEvent(686)

    -- THE FANGED ONE
    elseif theFangedOne ~= QUEST_COMPLETED then
        if theFangedOne == QUEST_AVAILABLE and lvl >= ADVANCED_JOB_LEVEL then
            player:startEvent(351)
        elseif theFangedOne == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.OLD_TIGERS_FANG) then
            player:startEvent(352)
        elseif player:hasKeyItem(tpz.ki.OLD_TIGERS_FANG) and theFangedOneCS ~= 1 then
            player:startEvent(357)
        elseif theFangedOneCS == 1 then
            player:startEvent(358)
        end

    -- SIN HUNTING
    elseif sinHunting == QUEST_AVAILABLE and job == tpz.job.RNG and lvl >= AF1_QUEST_LEVEL and sinHuntingCS == 0 then
        player:startEvent(523) -- start RNG AF1
    elseif sinHuntingCS > 0 and sinHuntingCS < 5 then
        player:startEvent(524) -- during quest RNG AF1
    elseif sinHuntingCS == 5 then
        player:startEvent(527) -- complete quest RNG AF1

    -- FIRE AND BRIMSTONE
    elseif sinHunting == QUEST_COMPLETED and job == tpz.job.RNG and lvl >= AF2_QUEST_LEVEL and fireAndBrimstone == QUEST_AVAILABLE and fireAndBrimstoneCS == 0 then
        player:startEvent(531) -- start RNG AF2
    elseif fireAndBrimstoneCS > 0 and fireAndBrimstoneCS < 4 then
        player:startEvent(532) -- during RNG AF2
    elseif fireAndBrimstoneCS == 4 then
        player:startEvent(535, 0, 13360, 1113) -- second part RNG AF2
    elseif fireAndBrimstoneCS == 5 then
        player:startEvent(536, 0, 13360, 1113) -- during second part RNG AF2

    -- UNBRIDLED PASSION
    elseif fireAndBrimstone == QUEST_COMPLETED and job == tpz.job.RNG and lvl >= AF3_QUEST_LEVEL and unbridledPassion == QUEST_AVAILABLE and unbridledPassion == 0 then
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

function onEventFinish(player, csid, option)
    -- THREE PATHS
    if csid == 686 then
        player:setCharVar("COP_Louverance_s_Path", 2)

    -- THE FANGED ONE
    elseif csid == 351 then
        player:addQuest(WINDURST, tpz.quest.id.windurst.THE_FANGED_ONE)
        player:setCharVar("TheFangedOneCS", 1)
    elseif (csid == 357 or csid == 358) and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.THE_FANGED_ONE, {item=13117, title=tpz.title.THE_FANGED_ONE, var={"TheFangedOne_Event", "TheFangedOneCS"}}) then
        player:delKeyItem(tpz.ki.OLD_TIGERS_FANG)
        player:unlockJob(tpz.job.RNG)
        player:messageSpecial(ID.text.PERIH_VASHAI_DIALOG)

    -- SIN HUNTING
    elseif csid == 523 then -- start quest RNG AF1
        player:addQuest(WINDURST, tpz.quest.id.windurst.SIN_HUNTING)
        npcUtil.giveKeyItem(player, tpz.ki.CHIEFTAINNESS_TWINSTONE_EARRING)
        player:setCharVar("sinHunting", 1)
    elseif csid == 527 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.SIN_HUNTING, {item=17188, var="sinHunting"}) then -- complete quest RNG AF1
        player:delKeyItem(tpz.ki.CHIEFTAINNESS_TWINSTONE_EARRING)
        player:delKeyItem(tpz.ki.PERCHONDS_ENVELOPE)

    -- FIRE AND BRIMSTONE
    elseif csid == 531 then -- start RNG AF2
        player:addQuest(WINDURST, tpz.quest.id.windurst.FIRE_AND_BRIMSTONE)
        player:setCharVar("fireAndBrimstone", 1)
    elseif csid == 535 then -- start second part RNG AF2
        player:setCharVar("fireAndBrimstone", 5)
    elseif csid == 537 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.FIRE_AND_BRIMSTONE, {item=12518, var="fireAndBrimstone"}) then -- complete quest RNG AF2
        player:confirmTrade()

    -- UNBRIDLED PASSION
    elseif csid == 541 then -- start RNG AF3
        player:addQuest(WINDURST, tpz.quest.id.windurst.UNBRIDLED_PASSION)
        player:setCharVar("unbridledPassion", 1)
    elseif csid == 546 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.UNBRIDLED_PASSION, {item=14099, var="unbridledPassion"}) then -- complete quest RNG AF3
        player:delKeyItem(tpz.ki.KOHS_LETTER)

    -- FROM SAPLINGS GROW
    else
        tpz.wsquest.handleEventFinish(wsQuest, player, csid, option, ID.text.EMPYREAL_ARROW_LEARNED)
    end
end
