-----------------------------------
-- Area: Castle Zvahl Baileys
--  NPC: Treasure Coffer
-- !zone 161
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('UnderOathCS') == 3 and
        not player:hasKeyItem(xi.keyItem.MIQUES_PAINTBRUSH)
    then
        xi.treasure.onTrade(player, npc, trade, 2, xi.keyItem.MIQUES_PAINTBRUSH)
    else
        xi.treasure.onTrade(player, npc, trade, 0, 0)
    end
end

entity.onTrigger = function(player, npc)
    xi.treasure.onTrigger(player, npc)
end

return entity
