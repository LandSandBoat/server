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
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- TO THE FORSAKEN MINES: Hare Meat
    if (
        player:getCurrentMission(BASTOK) == xi.mission.id.bastok.TO_THE_FORSAKEN_MINES and
        npcUtil.tradeHas(trade, 4358) and
        not player:hasItem(563) and
        not GetMobByID(ID.mob.BLIND_MOBY):isSpawned()
    ) then
        player:confirmTrade()
        SpawnMob(ID.mob.BLIND_MOBY):updateClaim(player)

    -- BLADE OF DEATH: Chaosbringer
    elseif (
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DEATH) == QUEST_ACCEPTED and
        player:getCharVar("ChaosbringerKills") >= 200 and
        npcUtil.tradeHas(trade, 16607)
    ) then
        player:startEvent(10)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 10 and npcUtil.completeQuest(player, BASTOK, xi.quest.id.bastok.BLADE_OF_DEATH, {item=16637, title= xi.title.BLACK_DEATH, var="ChaosbringerKills"})) then
        player:confirmTrade()
        player:delKeyItem(xi.ki.LETTER_FROM_ZEID)
    end
end

return entity
