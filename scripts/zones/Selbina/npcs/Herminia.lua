-----------------------------------
-- Area: Selbina
--  NPC: Herminia
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HACHIMAKI,  858 },
        { xi.item.KENPOGI,   1294 },
        { xi.item.TUNIC,     1456 },
        { xi.item.TEKKO,      712 },
        { xi.item.MITTS,      681 },
        { xi.item.SITABAKI,  1034 },
        { xi.item.KYAHAN,     660 },
        { xi.item.SOLEA,      629 },
    }

    player:showText(npc, zones[xi.zone.SELBINA].text.HERMINIA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
