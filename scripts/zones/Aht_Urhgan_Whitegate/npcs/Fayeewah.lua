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
        { xi.item.CUP_OF_CHAI,      68, },
        { xi.item.IRMIK_HELVASI,  2075, },
    }

    player:showText(npc, ID.text.FAYEEWAH_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
