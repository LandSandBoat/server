-----------------------------------
-- Area: Selbina
--  NPC: Herminia
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HACHIMAKI,  825 },
        { xi.item.KENPOGI,   1245 },
        { xi.item.TUNIC,     1400 },
        { xi.item.TEKKO,      685 },
        { xi.item.MITTS,      655 },
        { xi.item.SITABAKI,   995 },
        { xi.item.KYAHAN,     635 },
        { xi.item.SOLEA,      605 },
    }

    player:showText(npc, zones[xi.zone.SELBINA].text.HERMINIA_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
end

return entity
