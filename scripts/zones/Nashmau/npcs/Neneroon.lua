-----------------------------------
-- Area: Nashmau
--  NPC: Neneroon
-- Type: Item Deliverer
-- !pos -0.866    -5.999    36.942 53
-----------------------------------
local ID = zones[xi.zone.NASHMAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.NENE_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
