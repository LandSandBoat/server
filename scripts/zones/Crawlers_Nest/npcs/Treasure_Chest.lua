-----------------------------------
-- Area: Crawler Nest
--  NPC: Treasure Chest
-- Involved In Quest: Enveloped in Darkness
-- !zone 197
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        xi.quest.getVar(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.ENVELOPED_IN_DARKNESS, 'Prog') >= 2 and
        xi.quest.getVar(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.ENVELOPED_IN_DARKNESS, 'Time') == 0 and
        not player:hasKeyItem(xi.keyItem.CRAWLER_BLOOD)
    then
        xi.treasure.onTrade(player, npc, trade, 2, xi.keyItem.CRAWLER_BLOOD)
    else
        xi.treasure.onTrade(player, npc, trade, 0, 0)
    end
end

entity.onTrigger = function(player, npc)
    xi.treasure.onTrigger(player, npc)
end

return entity
