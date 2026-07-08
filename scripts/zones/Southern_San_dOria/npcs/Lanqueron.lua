-----------------------------------
-- Area: Southern San dOria
--  NPC: Lanqueron
-- Type: Item Deliverer NPC
-- Involved in Quest: Lost Chick
-- !pos 0.335 1.199 -28.404 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
