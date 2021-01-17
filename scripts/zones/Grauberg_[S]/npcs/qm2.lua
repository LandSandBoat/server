-----------------------------------
-- Area: Grauberg [S]
--  NPC: qm2 (???)
-- Involved In Quest: The Fumbling Friar
-- !pos 80 -1 457 89
-----------------------------------
local ID = require("scripts/zones/Grauberg_[S]/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_FUMBLING_FRIAR) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.ORNATE_PACKAGE) then
        npcUtil.giveKeyItem(player, tpz.ki.ORNATE_PACKAGE)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
