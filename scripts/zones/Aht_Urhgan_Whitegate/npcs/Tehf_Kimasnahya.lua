-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Tehf Kimasnahya
-- Type: Standard NPC
-- !pos -89.897 -1 6.199 50
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local gotitall = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.GOT_IT_ALL)
    local gotItAllProg = player:getCharVar("gotitallCS")
    local threeMenProg = player:getCharVar("threemenandaclosetCS")
    if gotitall == QUEST_AVAILABLE then
        player:startEvent(520)
    elseif gotItAllProg == 4 then
        player:startEvent(525)
    elseif gotItAllProg == 6 then
        player:startEvent(527)
    elseif gotItAllProg >= 7 and player:getCharVar("Wait1DayForgotitallCS_date") < os.time() and player:needToZone() == false then
        player:startEvent(528)
    elseif gotItAllProg >= 7 then
        player:startEvent(539)
    elseif gotItAllProg >= 1 and gotItAllProg <= 3 then
        player:startEvent(521)
    elseif threeMenProg == 5 then
        player:startEvent(843)
    elseif threeMenProg == 6 then
        player:startEvent(844)
    else
        player:startEvent(529)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 520 then
        player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.GOT_IT_ALL)
        player:setCharVar("gotitallCS", 1)
    elseif csid == 525 and option == 0 then
        player:setCharVar("gotitallCS", 5)
        player:delKeyItem(tpz.ki.VIAL_OF_LUMINOUS_WATER)
    elseif csid == 527 then
        player:setCharVar("gotitallCS", 7)
        player:setCharVar("Wait1DayForgotitallCS_date", getMidnight())
        player:needToZone(true)
    elseif csid == 539 then
        player:setCharVar("gotitallCS", 8)
    elseif csid == 528 then
        npcUtil.completeQuest(player, AHT_URHGAN, tpz.quest.id.ahtUrhgan.GOT_IT_ALL, {item=18257, var={"Wait1DayForgotitallCS_date", "gotitallCS"}})
    elseif csid == 843 and option == 1 then
        player:setCharVar("threemenandaclosetCS", 6)
    end
end
