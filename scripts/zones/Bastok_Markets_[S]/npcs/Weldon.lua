-----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Weldon
-- Type: Item Deliverer
-- !pos -191.575    -8    36.688 87
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.WELDON_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
