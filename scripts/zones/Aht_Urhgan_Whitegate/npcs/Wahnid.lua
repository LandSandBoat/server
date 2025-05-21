-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Wahnid
-- Type: Guild Merchant: Fishing Guild
-- !pos -31.720 -6.000 -94.919 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(60426, 1, 18, 6) then
        player:showText(npc, ID.text.WAHNID_SHOP_DIALOG)
    end
end

return entity
