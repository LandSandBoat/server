-----------------------------------
-- Area: Norg
--  NPC: Paleille
-- Type: Item Deliverer
-- !pos -82.667 -5.414 52.421 252
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.PALEILLE_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
