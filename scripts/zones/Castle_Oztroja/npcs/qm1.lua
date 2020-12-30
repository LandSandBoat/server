-----------------------------------
-- Area: Castle Oztroja
--  NPC: qm1 (???)
-- Involved in Quest: True Strength
-- !pos -100 -71 -132 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if
        player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.TRUE_STRENGTH) == QUEST_ACCEPTED and
        not player:hasItem(1100) and -- Xalmo's Feather
        npcUtil.tradeHas(trade, 4558) and -- Yagudo Drink
        npcUtil.popFromQM(player, npc, ID.mob.HUU_XALMO_THE_SAVAGE, {hide = 0})
    then
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
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
