-----------------------------------
-- Area: Bastok Markets
--  NPC: Zon-Fobun
-- Type: Quest Giver
-- !pos -241.293 -3 63.406 235
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local cCollector = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_CURSE_COLLECTOR)

    if cCollector == QUEST_AVAILABLE and player:getFameLevel(BASTOK) >=4 then
        player:startEvent(251) -- Quest Start Dialogue
    elseif cCollector == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.CURSEPAPER) and player:getCharVar("cCollectSilence") == 1 and player:getCharVar("cCollectCurse") == 1 then
        player:startEvent(252) -- Quest Completion Dialogue
    else
        player:startEvent(250)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 251 then
        player:addQuest(BASTOK, tpz.quest.id.bastok.THE_CURSE_COLLECTOR)
        npcUtil.giveKeyItem(player, tpz.ki.CURSEPAPER)
    elseif csid == 252 and npcUtil.completeQuest(player, BASTOK, tpz.quest.id.bastok.THE_CURSE_COLLECTOR, {item = 16387, var = {"cCollectSilence", "cCollectCurse"}}) then
        player:delKeyItem(tpz.ki.CURSEPAPER)
    end
end
