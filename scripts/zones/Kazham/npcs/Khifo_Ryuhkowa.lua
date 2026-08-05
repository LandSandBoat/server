-----------------------------------
-- Area: Kazham
--  NPC: Khifo Ryuhkowa
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.KUKRI,            6210 },
        { xi.item.RAM_DAO,        166320 },
        { xi.item.BRONZE_SPEAR,      880 },
        { xi.item.SPEAR,           17640 },
        { xi.item.PARTISAN,        82110 },
        { xi.item.CHESTNUT_CLUB,    1740 },
        { xi.item.BONE_CUDGEL,      5376 },
        { xi.item.CHESTNUT_WAND,    5712 },
        { xi.item.MAHOGANY_STAFF,  32340 },
        { xi.item.MAHOGANY_POLE,  107800 },
        { xi.item.BATTLE_BOW,      43200 },
        { xi.item.HAWKEYE,            60 },
        { xi.item.BOOMERANG,        1750 },
        { xi.item.WOODEN_ARROW,        4 },
    }

    player:showText(npc, zones[xi.zone.KAZHAM].text.KHIFORYUHKOWA_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
