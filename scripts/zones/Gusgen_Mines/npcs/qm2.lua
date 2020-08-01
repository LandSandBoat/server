-----------------------------------
-- Area: Gusgen Mines
--  NPC: qm2 (???)
-- Involved In Mission: Bastok 3-2
-- !pos 206 -60 -101 196
-----------------------------------
local ID = require("scripts/zones/Gusgen_Mines/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    -- TO THE FORSAKEN MINES: Hare Meat
    if (
        player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.TO_THE_FORSAKEN_MINES and
        npcUtil.tradeHas(trade, 4358) and
        not player:hasItem(563) and
        not GetMobByID(ID.mob.BLIND_MOBY):isSpawned()
    ) then
        player:confirmTrade()
        SpawnMob(ID.mob.BLIND_MOBY):updateClaim(player)

    -- BLADE OF DEATH: Chaosbringer
    elseif (
        player:getQuestStatus(BASTOK, tpz.quest.id.bastok.BLADE_OF_DEATH) == QUEST_ACCEPTED and
        player:getCharVar("ChaosbringerKills") >= 200 and
        npcUtil.tradeHas(trade, 16607)
    ) then
        player:startEvent(10)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10 and npcUtil.completeQuest(player, BASTOK, tpz.quest.id.bastok.BLADE_OF_DEATH, {item=16637, title=tpz.title.BLACK_DEATH, var="ChaosbringerKills"})) then
        player:confirmTrade()
        player:delKeyItem(tpz.ki.LETTER_FROM_ZEID)
    end
end
