-----------------------------------
-- Area: Promyvion Holla
--  NPC: Memory Flux 4th floor
-----------------------------------
local ID = require("scripts/zones/Promyvion-Holla/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED) == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.PROMYVION_HOLLA_SLIVER)
    then
        npcUtil.giveKeyItem(player, xi.ki.PROMYVION_HOLLA_SLIVER)
    else
        player:messageSpecial(ID.text.BARRIER_WOVEN)
    end
end

entity.onTrade = function(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
