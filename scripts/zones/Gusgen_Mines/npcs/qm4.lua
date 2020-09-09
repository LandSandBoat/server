-----------------------------------
-- Area: Gusgen Mines
--  NPC: qm4 (???)
-- Involved In Quest: Ghosts of the Past
-- !pos -174 0 369 196
-----------------------------------
local ID = require("scripts/zones/Gusgen_Mines/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    -- GHOSTS OF THE PAST: Pickaxe
    if (
        player:getQuestStatus(BASTOK, tpz.quest.id.bastok.GHOSTS_OF_THE_PAST) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, 605) and
        not player:hasItem(13122) and
        not GetMobByID(ID.mob.WANDERING_GHOST):isSpawned()
    ) then
        player:confirmTrade()
        SpawnMob(ID.mob.WANDERING_GHOST):updateClaim(player)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
