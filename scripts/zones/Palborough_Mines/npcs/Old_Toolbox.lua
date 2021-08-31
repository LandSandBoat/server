-----------------------------------
-- Area: Palborough Mines
--  NPC: Old Toolbox
-- Continues Quest: The Eleventh's Hour
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_ELEVENTH_S_HOUR) == QUEST_ACCEPTED and not player:hasKeyItem(xi.ki.OLD_TOOLBOX) then
        player:startEvent(23)
    else
        player:startEvent(22)
    end
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 23 and option == 0 then
        player:addKeyItem(xi.ki.OLD_TOOLBOX)
    end
end

entity.onEventFinish = function(player, csid, option)
end

return entity
