-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ratihb
-- Standard Info NPC
-- !pos 75.225 -6.000 -137.203 50
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local luckOfTheDraw = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.LUCK_OF_THE_DRAW)
    local againstAllOdds = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.AGAINST_ALL_ODDS)

    if luckOfTheDraw == QUEST_AVAILABLE and player:getMainLvl() >= ADVANCED_JOB_LEVEL then
        player:startEvent(547)
    elseif luckOfTheDraw == QUEST_COMPLETED and player:getCharVar("LuckOfTheDraw") == 5 then
        player:startEvent(552)
    elseif player:getCharVar("EquippedforAllOccasions") == 4 and player:getCharVar("LuckOfTheDraw") == 6 then
        player:startEvent(772)
    elseif againstAllOdds == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.LIFE_FLOAT) then
        player:startEvent(604)
    else
        player:startEvent(603)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 547 then
        player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.LUCK_OF_THE_DRAW)
        player:setCharVar("LuckOfTheDraw", 1)
    elseif csid == 552 then
        player:setCharVar("LuckOfTheDraw", 6)
    elseif csid == 772 then
        npcUtil.completeQuest(player, AHT_URHGAN, tpz.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS, {item = 18702, var = {"EquippedforAllOccasions", "LuckOfTheDraw"}})
    elseif csid == 604 then
        npcUtil.giveKeyItem(player, tpz.ki.LIFE_FLOAT)
    end
end
