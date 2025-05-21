-----------------------------------
-- Area: Hall of the Gods
--  NPC: Cermet Gate
-- Gives qualified players access to Ru'Aun Gardens.
-- !pos 0 -12 48 251
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.CERULEAN_CRYSTAL) then
        player:startEvent(1) -- NOTE: This CS onEventFinish is handled by ZM10 mission script
    else
        player:startEvent(2)
    end
end

return entity
