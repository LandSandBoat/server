-----------------------------------
-- Area: Fort Karugo Narugo [S]
--  NPC: Mortimer
-- Type: Item Deliverer
-- !pos -24.08 -68.508 93.88 96
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
