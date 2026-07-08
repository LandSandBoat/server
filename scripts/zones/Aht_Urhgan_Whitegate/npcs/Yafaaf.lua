-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Yafaaf
-- !pos 76.889 -7 -140.379 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BOWL_OF_SUTLAC,         1500, },
        { xi.item.CUP_OF_IMPERIAL_COFFEE,  450, },
    }

    player:showText(npc, ID.text.YAFAAF_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
