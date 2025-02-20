-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Fayeewah
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        5570,   68,    -- Cup of Chai
        5572, 2075     -- Irmik Helvasi
    }

    player:showText(npc, ID.text.FAYEEWAH_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
