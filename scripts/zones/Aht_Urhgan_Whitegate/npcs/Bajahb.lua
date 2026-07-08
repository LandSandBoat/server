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
        { xi.item.IRON_MASK,     10260, },
        { xi.item.CHAINMAIL,     15840, },
        { xi.item.CHAIN_MITTENS,  8460, },
        { xi.item.CHAIN_HOSE,    12600, },
        { xi.item.GREAVES,        7740, },
    }

    player:showText(npc, ID.text.BAJAHB_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
