-----------------------------------
-- Area: Konschtat Highlands
--  NPC: qm2 (???)
-- Involved in Quest: Forge Your Destiny
-- !pos -709 2 102 108
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.FORGE_YOUR_DESTINY) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, 1151) and -- Oriental Steel
        not GetMobByID(ID.mob.FORGER):isSpawned()
    then
        SpawnMob(ID.mob.FORGER):updateClaim(player)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
