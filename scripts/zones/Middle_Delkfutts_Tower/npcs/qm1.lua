-----------------------------------
-- Area: Middle Delfutt's Tower
--  NPC: ??? (qm1)
-- Involved In Quest: Blade of Evil
-- !pos 84 -79 77 157
-----------------------------------
local ID = require("scripts/zones/Middle_Delkfutts_Tower/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.BLADE_OF_EVIL) == QUEST_ACCEPTED and
        player:getCharVar("bladeOfEvilCS") == 0 and
        npcUtil.tradeHas(trade, 1114) and
        not GetMobByID(ID.mob.BLADE_OF_EVIL_MOB_OFFSET + 0):isSpawned() and
        not GetMobByID(ID.mob.BLADE_OF_EVIL_MOB_OFFSET + 1):isSpawned() and
        not GetMobByID(ID.mob.BLADE_OF_EVIL_MOB_OFFSET + 2):isSpawned()
    then
        player:confirmTrade()
        SpawnMob(ID.mob.BLADE_OF_EVIL_MOB_OFFSET + 0):updateClaim(player)
        SpawnMob(ID.mob.BLADE_OF_EVIL_MOB_OFFSET + 1):updateClaim(player)
        SpawnMob(ID.mob.BLADE_OF_EVIL_MOB_OFFSET + 2):updateClaim(player)
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
