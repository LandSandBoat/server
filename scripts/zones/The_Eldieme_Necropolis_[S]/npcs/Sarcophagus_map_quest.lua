-----------------------------------
-- Area: The Eldieme Necropolis (S)
--  NPC: Sarcophagus
-- Type: Quest NPC
-- !pos  336.594, -33.500, -56.728 175
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if
        player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.LOST_IN_TRANSLOCATION) == QUEST_ACCEPTED
        and not player:hasKeyItem(tpz.ki.RIGHT_MAP_PIECE)
    then
        player:startEvent(5)
    else
        player:messageSpecial(ID.text.SARCOPHAGUS_SEALED)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 5 then
        npcUtil.giveKeyItem(player, tpz.ki.RIGHT_MAP_PIECE)
    end
end
