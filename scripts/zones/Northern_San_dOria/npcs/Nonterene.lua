-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Nonterene
-- Type: Adventurer's Assistant NPC
-- !pos -6.347 0.000 -11.265 231
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.EXIT_THE_GAMBLER) == QUEST_ACCEPTED then
        player:startEvent(523)
    else
        player:startEvent(503)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
