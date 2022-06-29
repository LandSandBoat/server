-----------------------------------
-- Area: The Eldieme Necropolis (S)
--  NPC: Gravestone
-- Type: Quest NPC
-- !pos  254.428, -32.999, 20.001 175
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.LOST_IN_TRANSLOCATION) == QUEST_ACCEPTED
        and not player:hasKeyItem(xi.ki.MIDDLE_MAP_PIECE)
    then
        player:startEvent(4)
    else
        player:messageSpecial(ID.text.NAMES_CARVED_ON_STONE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 4 then
        npcUtil.giveKeyItem(player, xi.ki.MIDDLE_MAP_PIECE)
    end
end

return entity
