-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Khaf Jhifanm
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.DRIED_DATE,                 200, },
        { xi.item.FLASK_OF_AYRAN,             800, },
        { xi.item.BALIK_SANDVICI,            3750, },
        { xi.item.BAG_OF_WILDGRASS_SEEDS,     320, },
        { xi.item.SCROLL_OF_RAPTOR_MAZURKA,  4400, },
        { xi.item.EMPIRE_WAYSTONE,          10000, },
    }

    player:showText(npc, ID.text.KHAFJHIFANM_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
