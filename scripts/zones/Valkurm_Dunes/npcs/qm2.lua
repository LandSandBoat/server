-----------------------------------
-- Area: Valkurm Dunes
--  NPC: qm2 (???)
-- Involved In Quest: Messenger from Beyond
-- !pos -716 -10 66 103
-----------------------------------
local ID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        not GetMobByID(ID.mob.MARCHELUTE):isSpawned() and
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.MESSENGER_FROM_BEYOND) == xi.questStatus.QUEST_ACCEPTED and
        not player:hasItem(xi.item.TAVNAZIA_PASS)
    then
        SpawnMob(ID.mob.MARCHELUTE):updateClaim(player)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
