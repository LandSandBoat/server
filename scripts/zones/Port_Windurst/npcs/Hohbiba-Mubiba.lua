-----------------------------------
-- Area: Port Windurst
--  NPC: Hohbiba-Mubiba
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.MAPLE_WAND,       52, 3 },
        { xi.item.WILLOW_WAND,     370, 3 },
        { xi.item.YEW_WAND,       1566, 1 },
        { xi.item.BRONZE_ROD,      100, 3 },
        { xi.item.BRASS_ROD,       690, 3 },
        { xi.item.ASH_CLUB,         72, 3 },
        { xi.item.CHESTNUT_CLUB,  1740, 3 },
        { xi.item.BONE_CUDGEL,    5376, 2 },
        { xi.item.ASH_STAFF,        63, 3 },
        { xi.item.HOLLY_STAFF,     635, 3 },
        { xi.item.ELM_STAFF,      3606, 1 },
        { xi.item.ASH_POLE,        420, 3 },
        { xi.item.HOLLY_POLE,     5076, 2 },
        { xi.item.ELM_POLE,      18240, 1 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.HOHBIBAMUBIBA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
