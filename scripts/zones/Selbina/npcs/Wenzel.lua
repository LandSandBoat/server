-----------------------------------
-- Area: Selbina
--  NPC: Wenzel
-- Type: Item Deliverer
-- !pos 31.961 -14.661 57.997 248
-----------------------------------
local ID = zones[xi.zone.SELBINA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.WENZEL_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
