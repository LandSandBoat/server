-----------------------------------
-- Area: Norg
--  NPC: Washu
-- Involved in Quest: Yomi Okuri
-- Starts and finishes Quest: Stop Your Whining
-- !pos 49 -6 15 252
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    -- YOMI OKURI (SAM AF2)
    if (
        player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.YOMI_OKURI) == QUEST_ACCEPTED and
        player:getCharVar("yomiOkuriKilledNM") == 0 and
        not player:hasKeyItem(tpz.ki.WASHUS_TASTY_WURST) and
        not player:hasKeyItem(tpz.ki.YOMOTSU_FEATHER) and
        npcUtil.tradeHas(trade, {939, 4360, 4372, 4382}) -- Hecteyes Eye, Bastore Sardine, Giant Sheep Meat, Frost Turnip
    ) then
        player:startEvent(150)
    end
end

function onTrigger(player, npc)
    local stopYourWhining = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.STOP_YOUR_WHINING)

    -- YOMI OKURI (SAM AF2)
    if (player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.YOMI_OKURI) == QUEST_ACCEPTED) then
        if (player:getCharVar("yomiOkuriCS") == 1) then
            player:startEvent(148) -- start quest
        elseif (player:hasKeyItem(tpz.ki.WASHUS_TASTY_WURST)) then
            player:startEvent(151) -- remind objective
        elseif (player:getCharVar("yomiOkuriKilledNM") == 0 and not player:hasKeyItem(tpz.ki.WASHUS_TASTY_WURST)) then
            player:startEvent(149) -- remind ingredients
        end

    -- STOP YOUR WHINING
    elseif (stopYourWhining == QUEST_AVAILABLE and player:getFameLevel(NORG) >= 4 and player:getMainLvl() >= 10) then
        player:startEvent(21) -- start quest
    elseif (stopYourWhining == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.EMPTY_BARREL)) then
        player:startEvent(22) -- remind objective
    elseif (stopYourWhining == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.BARREL_OF_OPOOPO_BREW)) then
        player:startEvent(23) -- finish quest
    elseif (stopYourWhining == QUEST_COMPLETED) then
        player:startEvent(24) -- final dialog

    -- DEFAULT DIALOG
    else
        player:startEvent(80)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- YOMI OKURI (SAM AF2)
    if (csid == 148) then
        player:setCharVar("yomiOkuriCS", 2)
    elseif (csid == 150) then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, tpz.ki.WASHUS_TASTY_WURST)
        player:setCharVar("yomiOkuriCS", 3)

    -- STOP YOUR WHINING
    elseif (csid == 21 and option == 1) then
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.STOP_YOUR_WHINING)
        npcUtil.giveKeyItem(player, tpz.ki.EMPTY_BARREL)
    elseif (csid == 23 and npcUtil.completeQuest(player, OUTLANDS, tpz.quest.id.outlands.STOP_YOUR_WHINING, {item=4952, fame=75, fameArea=NORG, title=tpz.title.APPRENTICE_SOMMELIER})) then -- Scroll of Hojo: Ichi
        player:delKeyItem(tpz.ki.BARREL_OF_OPOOPO_BREW)
    end
end
