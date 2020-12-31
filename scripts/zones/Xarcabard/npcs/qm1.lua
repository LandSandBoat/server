-----------------------------------
-- Area: Xarcabard
--  NPC: qm1 (???)
-- Involved in Quests: The Three Magi
-- !pos -331 -29 -49 112
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if
        player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.THE_THREE_MAGI) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, 613) and
        not player:hasItem(1104) and
        npcUtil.popFromQM(player, npc, ID.mob.CHAOS_ELEMENTAL)
    then
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
