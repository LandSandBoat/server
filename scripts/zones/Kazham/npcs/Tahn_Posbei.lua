-----------------------------------
-- Area: Kazham
--  NPC: Tahn Posbei
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LAUAN_SHIELD,        126 },
        { xi.item.MAHOGANY_SHIELD,    5229 },
        { xi.item.ROUND_SHIELD,      68030 },
        { xi.item.BEETLE_MASK,        8019 },
        { xi.item.BEETLE_HARNESS,    12363 },
        { xi.item.BEETLE_MITTENS,     6514 },
        { xi.item.BEETLE_SUBLIGAR,    9891 },
        { xi.item.BEETLE_LEGGINGS,    6085 },
        { xi.item.LEATHER_BANDANA,     462 },
        { xi.item.LEATHER_VEST,        705 },
        { xi.item.LEATHER_GLOVES,      378 },
        { xi.item.LEATHER_HIGHBOOTS,   352 },
        { xi.item.COEURL_GORGET,     32844 },
    }

    player:showText(npc, zones[xi.zone.KAZHAM].text.TAHNPOSBEI_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
