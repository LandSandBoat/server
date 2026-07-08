-----------------------------------
-- Area: Norg
--  NPC: Spasija
-- Type: Item Deliverer
-- !pos -82.896 -5.414 55.271 252
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.SPASIJA_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
