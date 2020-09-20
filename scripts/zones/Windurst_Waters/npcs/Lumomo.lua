-----------------------------------
-- Area: Windurst Waters
--  NPC: Lumomo
-- Type: Standard NPC
-- !pos -55.770 -5.499 18.914 238
--  638  818 820    822  823
-- Auto-Script: Requires Verification (Verfied By Brawndo)
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local ecoWarWindurst = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.ECO_WARRIOR)
    local ecoWarActiveNation = player:getCharVar("ECO_WARRIOR_ACTIVE")
    if (player:hasKeyItem(tpz.ki.INDIGESTED_MEAT) and ecoWarActiveNation == 238) then
        player:startEvent(822) -- quest done
    elseif (ecoWarActiveNation < 1 and player:getFameLevel(WINDURST) >= 1 and player:getCharVar("ECO-WAR_ConquestWeek") ~= getConquestTally()) then
        player:startEvent(818) -- Start CS
    elseif (ecoWarActiveNation ~= 238 and ecoWarActiveNation > 1) then
        player:startEvent(823)
    elseif (ecoWarWindurst ~= QUEST_AVAILABLE and ecoWarActiveNation == 238  and player:getCharVar("ECO-WAR_ConquestWeek") ~= getConquestTally()) then
        player:startEvent(820) -- reminder
    else
        player:startEvent(821) -- Default chit-chat
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 818 and option == 1) then
        if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.ECO_WARRIOR) == QUEST_AVAILABLE) then
            player:addQuest(WINDURST, tpz.quest.id.windurst.ECO_WARRIOR)
        end
        player:setCharVar("ECO_WARRIOR_ACTIVE", player:getZoneID())
        player:setCharVar("ECO-WAR_ConquestWeek", 0)
    elseif (csid == 822) then
        if (player:getFreeSlotsCount() >= 1) then
            player:completeQuest(WINDURST, tpz.quest.id.windurst.ECO_WARRIOR)
            player:delKeyItem(tpz.ki.INDIGESTED_MEAT)
            player:addGil(GIL_RATE * 5000)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE * 5000)
            player:addItem(4198)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4198)
            player:addTitle(tpz.title.EMERALD_EXTERMINATOR)
            player:addFame(WINDURST, 80)
            player:setCharVar("ECO_WAR_WIN-NMs_killed", 0)
            player:setCharVar("ECO-WAR_ConquestWeek", getConquestTally())
            player:setCharVar("ECO_WARRIOR_ACTIVE", 0)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4198)
        end
    end
end
