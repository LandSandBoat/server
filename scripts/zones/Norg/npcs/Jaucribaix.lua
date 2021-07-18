-----------------------------------
-- Area: Norg
--  NPC: Jaucribaix
-- Starts and Finishes Quest: Forge Your Destiny, The Sacred Katana, Yomi Okuri, A Thief in Norg!?, The Potential Within
-- !pos 91 -7 -8 252
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.A_THIEF_IN_NORG) == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.CHARRED_HELM) and npcUtil.tradeHas(trade, 823)) then -- Gold Thread
        player:startEvent(162)
    end
end

entity.onTrigger = function(player, npc)
    local theSacredKatana   = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_SACRED_KATANA)
    local yomiOkuri         = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI)
    local aThiefinNorg      = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.A_THIEF_IN_NORG)
    local yomiOkuriCS       = player:getCharVar("yomiOkuriCS")
    local aThiefinNorgCS    = player:getCharVar("aThiefinNorgCS")
    local mLvl              = player:getMainLvl()
    local mJob              = player:getMainJob()

    -- YOMI OKURI
    if (theSacredKatana == QUEST_COMPLETED and yomiOkuri == QUEST_AVAILABLE and mJob == xi.job.SAM and mLvl >= xi.settings.AF2_QUEST_LEVEL) then
        -- Check getMustZone against The Sacred Katana
        player:startEvent(player:needToZone() and 142 or 146) -- event with or without needing to zone
    elseif (yomiOkuri == QUEST_ACCEPTED) then
        if (yomiOkuriCS <= 3) then
            player:startEvent(player:hasKeyItem(xi.ki.YOMOTSU_FEATHER) and 152 or 147) -- accept feather or remind objective
        elseif (yomiOkuriCS == 4) then
            player:startEvent(player:needToZone() and 153 or 154) -- event with or without needing to zone
        elseif (player:hasKeyItem(xi.ki.YOMOTSU_HIRASAKA)) then
            player:startEvent(155)
        elseif (player:hasKeyItem(xi.ki.FADED_YOMOTSU_HIRASAKA)) then
            player:startEvent(156)
        end

    -- A THIEF IN NORG
    elseif (yomiOkuri == QUEST_COMPLETED and aThiefinNorg == QUEST_AVAILABLE and mJob == xi.job.SAM and mLvl >= xi.settings.AF3_QUEST_LEVEL) then
        player:startEvent(player:needToZone() and 157 or 158) -- even with or without needing to zone
    elseif (aThiefinNorg == QUEST_ACCEPTED) then
        if (aThiefinNorgCS < 5) then
            player:startEvent(159) -- remind objective
        elseif (aThiefinNorgCS == 5) then
            player:startEvent(166) -- give banishing charm
        elseif (aThiefinNorgCS == 6) then
            player:startEvent(player:hasItem(1166) and 167 or 168) -- remind objective or give new banishing charm
        elseif (aThiefinNorgCS == 7) then
            player:startEvent(160) -- bring gold thread
        elseif (aThiefinNorgCS == 8) then
            player:startEvent(161) -- remind objective
        elseif (aThiefinNorgCS == 9) then
            player:startEvent(player:needToZone() and 163 or 164) -- event with or without needing to zone
        end
    elseif (aThiefinNorg == QUEST_COMPLETED) then
        player:startEvent(165) -- new default dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- YOMI OKURI
    if (csid == 146 and option == 1) then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI)
        player:setCharVar("yomiOkuriCS", 1)
    elseif (csid == 152) then
        player:delKeyItem(xi.ki.YOMOTSU_FEATHER)
        player:setCharVar("yomiOkuriCS", 4)
        player:needToZone(true)
    elseif (csid == 154) then
        player:setCharVar("yomiOkuriCS", 5)
        npcUtil.giveKeyItem(player, xi.ki.YOMOTSU_HIRASAKA)
    elseif (csid == 156 and npcUtil.completeQuest(player, OUTLANDS, xi.quest.id.outlands.YOMI_OKURI, {item=14100, fame=40, fameArea=NORG, var="yomiOkuriCS"})) then -- Myochin Sune-Ate
        player:delKeyItem(xi.ki.FADED_YOMOTSU_HIRASAKA)
        player:needToZone(true)

    -- A THIEF IN NORG
    elseif (csid == 158 and option == 1) then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.A_THIEF_IN_NORG)
        player:setCharVar("aThiefinNorgCS", 1)
    elseif ((csid == 166 or csid == 168) and npcUtil.giveItem(player, xi.items.BANISHING_CHARM)) then -- Banishing Charm
        player:setCharVar("aThiefinNorgCS", 6)
    elseif (csid == 160) then
        player:setCharVar("aThiefinNorgCS", 8)
    elseif (csid == 162) then
        player:confirmTrade()
        player:delKeyItem(xi.ki.CHARRED_HELM)
        player:setCharVar("aThiefinNorgCS", 9)
        player:needToZone(true)
    elseif (csid == 164) then
        npcUtil.completeQuest(player, OUTLANDS, xi.quest.id.outlands.A_THIEF_IN_NORG, {item=13868, title=xi.title.PARAGON_OF_SAMURAI_EXCELLENCE, fame=60, fameArea=NORG, var={"aThiefinNorgCS"}})
    end
end

return entity
