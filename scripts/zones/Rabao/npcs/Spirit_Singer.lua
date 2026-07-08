-----------------------------------
-- Area: Rabao
--  NPC: Spirit Singer
-- Type: Item Deliverer
-- !pos 140.337 7.999 80.661 247
-----------------------------------
local ID = zones[xi.zone.RABAO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.SPIRIT_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
