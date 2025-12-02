-----------------------------------
-- Area: Kazham
--  NPC: Khifo Ryuhkowa
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.KUKRI,            6520 },
        { xi.item.RAM_DAO,        174636 },
        { xi.item.BRONZE_SPEAR,      924 },
        { xi.item.SPEAR,           18522 },
        { xi.item.PARTISAN,        86215 },
        { xi.item.CHESTNUT_CLUB,    1827 },
        { xi.item.BONE_CUDGEL,      5644 },
        { xi.item.CHESTNUT_WAND,    5997 },
        { xi.item.MAHOGANY_STAFF,  33957 },
        { xi.item.MAHOGANY_POLE,  113190 },
        { xi.item.BATTLE_BOW,      45360 },
        { xi.item.HAWKEYE,            63 },
        { xi.item.BOOMERANG,        1837 },
        { xi.item.WOODEN_ARROW,        4 },
    }

    player:showText(npc, zones[xi.zone.KAZHAM].text.KHIFORYUHKOWA_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
