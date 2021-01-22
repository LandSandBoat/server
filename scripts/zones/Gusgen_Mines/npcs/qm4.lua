-----------------------------------
-- Area: Gusgen Mines
--  NPC: qm4 (???)
-- Involved In Quest: Ghosts of the Past
-- !pos -174 0 369 196
-----------------------------------
local ID = require("scripts/zones/Gusgen_Mines/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- GHOSTS OF THE PAST: Pickaxe
    if (
        player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.GHOSTS_OF_THE_PAST) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, 605) and
        not player:hasItem(13122) and
        not GetMobByID(ID.mob.WANDERING_GHOST):isSpawned()
    ) then
        player:confirmTrade()
        SpawnMob(ID.mob.WANDERING_GHOST):updateClaim(player)
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
