-----------------------------------
-- Area: Upper Jeuno
--  NPC: Chocobo
-- Finishes Quest: Chocobo's Wounds
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:hasItemQty(xi.item.BUNCH_OF_GYSAHL_GREENS, 1) then
        player:startEvent(38)
    end
end

return entity
