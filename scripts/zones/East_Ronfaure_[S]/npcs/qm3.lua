-----------------------------------
-- Area: East Ronfaure [S]
--  NPC: qm3 "???"
-- Involved in Quests: Steamed Rams
-- !pos 312.821 -30.495 -67.15
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/campaign")
local ID = require("scripts/zones/East_Ronfaure_[S]/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.STEAMED_RAMS) == QUEST_ACCEPTED) then
        if (player:hasKeyItem(tpz.ki.CHARRED_PROPELLER)) then
            player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
        else
            player:startEvent(1)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- print("CSID:", csid)
    -- print("RESULT:", option)
    if (csid == 1) then
        player:addKeyItem(tpz.ki.CHARRED_PROPELLER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CHARRED_PROPELLER)
    end
end
