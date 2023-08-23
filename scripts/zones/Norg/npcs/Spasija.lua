-----------------------------------
-- Area: Norg
--  NPC: Spasija
-- Type: Item Deliverer
-- !pos -82.896 -5.414 55.271 252
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.SPASIJA_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
