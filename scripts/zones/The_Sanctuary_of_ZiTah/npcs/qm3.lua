-----------------------------------
-- Area: The Sanctuary of Zitah
--  NPC: ???
-- Involved In Quest: The Sacred Katana
-- !pos -416 0 46 121
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.THE_SACRED_KATANA) == QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, 1168) and npcUtil.popFromQM(player, npc, ID.mob.ISONADE, {hide = 0}) then -- Sack of Fish Bait
            player:confirmTrade()
            player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
        end
    end
end

function onTrigger(player, npc)
    if player:getCharVar("IsonadeKilled") == 1 then
        player:setCharVar("IsonadeKilled", 0)
        npcUtil.giveKeyItem(player, tpz.ki.HANDFUL_OF_CRYSTAL_SCALES)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
