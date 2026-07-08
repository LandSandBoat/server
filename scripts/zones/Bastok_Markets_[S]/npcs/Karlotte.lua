-----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Karlotte
-- Type: Item Deliverer
-- !pos -191.646 -8 -36.349 87
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.KARLOTTE_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
