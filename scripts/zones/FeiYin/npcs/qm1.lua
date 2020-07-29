-----------------------------------
-- Area: FeiYin
--  NPC: qm1 (???)
-- Involved In Quest: Pieuje's Decision
-- !pos -55 -16 69 204
-----------------------------------
local ID = require("scripts/zones/FeiYin/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (
        player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.PIEUJE_S_DECISION) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, 1098) and -- Tavnazia Bell
        not player:hasItem(13842) and -- Tavnazian Mask
        not GetMobByID(ID.mob.ALTEDOUR_I_TAVNAZIA):isSpawned()
    ) then
        player:confirmTrade()
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
        SpawnMob(ID.mob.ALTEDOUR_I_TAVNAZIA):updateClaim(player)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
