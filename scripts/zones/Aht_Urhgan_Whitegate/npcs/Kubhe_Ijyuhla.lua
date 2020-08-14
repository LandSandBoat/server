-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Kubhe Ijyuhla
-- Standard Info NPC
-- !pos 23.257 0.000 21.532 50
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local threeMenProg = player:getCharVar("threemenandaclosetCS")
    local threeMenQuest = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.THREE_MEN_AND_A_CLOSET)
    if player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.GOT_IT_ALL) == QUEST_COMPLETED and threeMenQuest == QUEST_AVAILABLE then
        player:startEvent(836)
    elseif threeMenProg == 2 then
        player:startEvent(837)
    elseif threeMenProg == 3 then
        player:startEvent(838)
    elseif threeMenProg == 4 then
        player:startEvent(839)
    elseif threeMenProg == 5 then
        player:startEvent(842)
    elseif threeMenProg == 6 then
        player:startEvent(845)
    elseif threeMenQuest == QUEST_COMPLETED then
        player:startEvent(846)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 836 then
        player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.THREE_MEN_AND_A_CLOSET)
        player:setCharVar("threemenandaclosetCS", 2)
    elseif csid == 838 then
        player:setCharVar("threemenandaclosetCS", 4)
    elseif csid == 845 then
        npcUtil.completeQuest(player, AHT_URHGAN, tpz.quest.id.ahtUrhgan.THREE_MEN_AND_A_CLOSET, { item=2184, var="threemenandaclosetCS"})
    end
end
