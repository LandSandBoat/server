-----------------------------------
-- Area: Al Zahbi
--  NPC: Mabebe
-- Type: Item Deliverer
-- !pos -27.551 0 -141.095 48
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
