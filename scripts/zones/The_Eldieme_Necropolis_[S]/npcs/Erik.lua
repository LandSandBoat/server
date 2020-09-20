-----------------------------------
-- Area: The Eldieme Necropolis (S)
--  NPC: Erik
-- Type: Quest NPC
-- !pos  258.643, -33.249, 99.901 175
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
        and not player:hasKeyItem(tpz.ki.LEFT_MAP_PIECE)
    then
        player:startEvent(3)
    else
        player:startEvent(1)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 3 then
        npcUtil.giveKeyItem(player, tpz.ki.LEFT_MAP_PIECE)
    end
end
