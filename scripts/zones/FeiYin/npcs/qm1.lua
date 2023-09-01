-----------------------------------
-- Area: FeiYin
--  NPC: qm1 (???)
-- Involved In Quest: Pieuje's Decision
-- !pos -55 -16 69 204
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PIEUJE_S_DECISION) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, xi.item.TAVNAZIA_BELL) and
        not player:hasItem(xi.item.TAVNAZIAN_MASK) and
        not GetMobByID(ID.mob.ALTEDOUR_I_TAVNAZIA):isSpawned()
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
        SpawnMob(ID.mob.ALTEDOUR_I_TAVNAZIA):updateClaim(player)
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
