-----------------------------------
-- Area: Norg
--  NPC: Paleille
-- Type: Item Deliverer
-- !pos -82.667 -5.414 52.421 252
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.PALEILLE_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
