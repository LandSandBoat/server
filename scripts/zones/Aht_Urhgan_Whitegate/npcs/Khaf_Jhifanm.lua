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
        { xi.item.DRIED_DATE,                 200, astralCandescence = false },
        { xi.item.FLASK_OF_AYRAN,             800, astralCandescence = true  },
        { xi.item.BALIK_SANDVICI,            3750, astralCandescence = true  },
        { xi.item.BAG_OF_WILDGRASS_SEEDS,     320, astralCandescence = false },
        { xi.item.SCROLL_OF_RAPTOR_MAZURKA,  4400, astralCandescence = false },
        { xi.item.EMPIRE_WAYSTONE,          10000, astralCandescence = false },
    }

    player:showText(npc, ID.text.KHAFJHIFANM_SHOP_DIALOG)
    xi.besieged.shop(player, stock)
end

return entity
