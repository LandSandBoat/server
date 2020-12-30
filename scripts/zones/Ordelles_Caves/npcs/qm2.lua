-----------------------------------
-- Area: Ordelle's Caves
--  NPC: ??? (qm2)
-- Involved in Quest: A Squire's Test II
-- !pos -94 1 273 193
-------------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.A_SQUIRE_S_TEST_II) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.STALACTITE_DEW) and player:getCharVar("SquiresTestII") == 0 then
        player:setCharVar("SquiresTestII", os.time())
        player:messageSpecial(ID.text.A_SQUIRE_S_TEST_II_DIALOG_I)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
