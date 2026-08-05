-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Arachagnon
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.ELVAAN_JERKIN,      300, },
        { xi.item.ELVAAN_BODICE,      300, },
        { xi.item.ELVAAN_GLOVES,      180, },
        { xi.item.ELVAAN_GAUNTLETS,   180, },
        { xi.item.ELVAAN_M_CHAUSSES,  260, },
        { xi.item.ELVAAN_F_CHAUSSES,  260, },
        { xi.item.ELVAAN_M_LEDELSENS, 180, },
        { xi.item.ELVAAN_F_LEDELSENS, 180, },
    }

    player:showText(npc, ID.text.ARACHAGNON_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.SANDORIA)
end

return entity
