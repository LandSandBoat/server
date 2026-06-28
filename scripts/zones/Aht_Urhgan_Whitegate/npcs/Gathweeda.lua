-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Gathweeda
--  Guild Merchant: Alchemist Guild
-- !pos -81.322 -6.000 140.273 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, ID.text.GATHWEEDA_SHOP_DIALOG)
    end
end

return entity
