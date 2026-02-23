-----------------------------------
-- Area: FeiYin
--  NPC: qm1 (???)
-- Involved In Quest: Pieuje's Decision
-- !pos -55 -16 69 204
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.PIEUJES_DECISION) == xi.questStatus.QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, xi.item.TAVNAZIA_BELL) and
        not player:hasItem(xi.item.TAVNAZIAN_MASK) and
        not GetMobByID(ID.mob.ALTEDOUR_I_TAVNAZIA):isSpawned()
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.EVIL_PRESENCE)
        SpawnMob(ID.mob.ALTEDOUR_I_TAVNAZIA):updateClaim(player)
    end
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.PIEUJES_DECISION) == xi.questStatus.QUEST_ACCEPTED then
        player:messageSpecial(ID.text.SOUL_OF_TAVNAZIA)
    else
        player:messageSpecial(ID.text.YOU_FIND_NOTHING)
    end
end

return entity
