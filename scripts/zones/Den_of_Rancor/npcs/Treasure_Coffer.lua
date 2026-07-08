-----------------------------------
-- Area: Den of Rancor
--  NPC: Treasure Coffer
-- !zone 160
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local reward = xi.treasure.onTrade(player, npc, trade, 0, 0)

    if reward > 0 then
        xi.expeditionaryForce.onChestOpen(player)
    end
end

entity.onTrigger = function(player, npc)
    xi.treasure.onTrigger(player, npc)
end

return entity
