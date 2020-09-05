-----------------------------------
-- Area: Yhoator Jungle
--  NPC: ??? (qm3)
-- Involved in Quest: True will
-- !pos 203 0.1 82 124
-----------------------------------
local ID = require("scripts/zones/Yhoator_Jungle/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.TRUE_WILL) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.OLD_TRICK_BOX) then
        if player:getCharVar("trueWillKilledNM") > 0 then
            npcUtil.giveKeyItem(player, tpz.ki.OLD_TRICK_BOX)
            player:setCharVar("trueWillKilledNM", 0)
        else
            npcUtil.popFromQM(player, npc, {ID.mob.KAPPA_AKUSO, ID.mob.KAPPA_BONZE, ID.mob.KAPPA_BIWA}, { hide = 0 })
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
