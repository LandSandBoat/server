-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Gathweeda
--  Guild Merchant: Alchemist Guild
-- !pos -81.322 -6.000 140.273 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(60425, 8, 23, 5) then
        player:showText(npc, ID.text.GATHWEEDA_SHOP_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
