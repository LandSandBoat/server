-----------------------------------
-- Area: Vunkerl_Inlet_[S]
--  NPC: qm4 (???)
-- Involved In Quest: REDEEMING_ROCKS
-- !pos -412 -29 -45 83
-----------------------------------
local ID = require("scripts/zones/Vunkerl_Inlet_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.REDEEMING_ROCKS) and player:getCharVar("RedeemingRocksProg") == 3 then
        player:addKeyItem(953) -- 4th stop for quest "Redeeming Rocks"
        player:messageSpecial(ID.text.KEYITEM_OBTAINED,tpz.ki.PIECE_OF_KIONITE)
        player:setCharVar("RedeemingRocksProg", 4)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end