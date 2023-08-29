-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Oaken Box
-- Involved In Quest: Peace for the Spirit
-- !pos -164 0.1 225 200
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PEACE_FOR_THE_SPIRIT) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, xi.item.NAIL_PULLER)
    then
        player:startEvent(14)
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getCharVar('peaceForTheSpiritCS') == 4 and
        not player:hasItem(xi.item.NAIL_PULLER) and
        not GetMobByID(ID.mob.GUARDIAN_STATUE):isSpawned()
    then
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
        SpawnMob(ID.mob.GUARDIAN_STATUE):updateClaim(player)
    else
        player:messageSpecial(ID.text.YOU_FIND_NOTHING)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 14 then
        player:confirmTrade()
        player:setCharVar('peaceForTheSpiritCS', 5)
    end
end

return entity
