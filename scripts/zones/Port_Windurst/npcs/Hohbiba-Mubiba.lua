-----------------------------------
-- Area: Port Windurst
--  NPC: Hohbiba-Mubiba
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.MAPLE_WAND,       54, 3 },
        { xi.item.WILLOW_WAND,     384, 3 },
        { xi.item.YEW_WAND,       1628, 1 },
        { xi.item.BRONZE_ROD,      104, 3 },
        { xi.item.BRASS_ROD,       717, 3 },
        { xi.item.ASH_CLUB,         74, 3 },
        { xi.item.CHESTNUT_CLUB,  1809, 3 },
        { xi.item.BONE_CUDGEL,    5591, 2 },
        { xi.item.ASH_STAFF,        66, 3 },
        { xi.item.HOLLY_STAFF,     660, 3 },
        { xi.item.ELM_STAFF,      3750, 1 },
        { xi.item.ASH_POLE,        436, 3 },
        { xi.item.HOLLY_POLE,     5279, 2 },
        { xi.item.ELM_POLE,      18969, 1 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.HOHBIBAMUBIBA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
