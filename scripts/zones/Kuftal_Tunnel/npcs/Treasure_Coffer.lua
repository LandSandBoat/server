-----------------------------------
-- Area: Kuftal Tunnel
--  NPC: Treasure Coffer
-- !zone 174
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('trueWillCS') == 2 and
        not player:hasKeyItem(xi.keyItem.LARGE_TRICK_BOX)
    then
        xi.treasure.onTrade(player, npc, trade, 2, xi.keyItem.LARGE_TRICK_BOX)
    elseif
        player:getCharVar('KnightStalker_Progress') == 1 and
        not player:hasKeyItem(xi.keyItem.CHALLENGE_TO_THE_ROYAL_KNIGHTS)
    then
        xi.treasure.onTrade(player, npc, trade, 2, xi.keyItem.CHALLENGE_TO_THE_ROYAL_KNIGHTS)
    else
        xi.treasure.onTrade(player, npc, trade, 0, 0)
    end
end

entity.onTrigger = function(player, npc)
    xi.treasure.onTrigger(player, npc)
end

return entity
