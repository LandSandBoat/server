-----------------------------------
-- Area: Kazham
--  NPC: Tahn Posbei
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LAUAN_SHIELD,        120 },
        { xi.item.MAHOGANY_SHIELD,    4980 },
        { xi.item.ROUND_SHIELD,      64791 },
        { xi.item.BEETLE_MASK,        7638 },
        { xi.item.BEETLE_HARNESS,    11775 },
        { xi.item.BEETLE_MITTENS,     6204 },
        { xi.item.BEETLE_SUBLIGAR,    9420 },
        { xi.item.BEETLE_LEGGINGS,    5796 },
        { xi.item.LEATHER_BANDANA,     440 },
        { xi.item.LEATHER_VEST,        672 },
        { xi.item.LEATHER_GLOVES,      360 },
        { xi.item.LEATHER_HIGHBOOTS,   336 },
        { xi.item.COEURL_GORGET,     31280 },
    }

    player:showText(npc, zones[xi.zone.KAZHAM].text.TAHNPOSBEI_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
