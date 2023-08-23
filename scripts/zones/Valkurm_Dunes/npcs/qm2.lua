-----------------------------------
-- Area: Valkurm Dunes
--  NPC: qm2 (???)
-- Involved In Quest: Messenger from Beyond
-- !pos -716 -10 66 103
-----------------------------------
local ID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        not GetMobByID(ID.mob.MARCHELUTE):isSpawned() and
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.MESSENGER_FROM_BEYOND) == QUEST_ACCEPTED and
        not player:hasItem(xi.item.TAVNAZIA_PASS)
    then
        SpawnMob(ID.mob.MARCHELUTE):updateClaim(player)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
