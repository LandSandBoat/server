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
        5567,   200,    -- Dried Date
        5576,   800,    -- Ayran
        5590,  3750,    -- Balik Sandvici
        2235,   320,    -- Wildgrass Seeds
        5075,  4400,    -- Scroll of Raptor Mazurka
        2872, 10000     -- Empire Waystone
    }

    player:showText(npc, ID.text.KHAFJHIFANM_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
