-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Bajahb
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        12424, 10260,    -- Iron Mask
        12552, 15840,    -- Chainmail
        12680,  8460,    -- Chain Mittens
        12808, 12600,    -- Chain Hose
        12936,  7740     -- Greaves
    }

    player:showText(npc, ID.text.BAJAHB_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
