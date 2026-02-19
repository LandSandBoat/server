-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Wahraga
--  Guild Merchant: Alchemist Guild
-- !pos -76.836 -6.000 140.331 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(60425, 8, 23, 5) then
        player:showText(npc, ID.text.WAHRAGA_SHOP_DIALOG)
    end
end

return entity
