-----------------------------------
-- Area: Port Windurst
--  NPC: Taniko-Maniko
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.CAT_BAGHNAKHS,    120, 3 },
        { xi.item.CESTI,            149, 3 },
        { xi.item.BRASS_KNUCKLES,   936, 3 },
        { xi.item.BRASS_BAGHNAKHS, 1757, 3 },
        { xi.item.BONE_AXE,        4851, 3 },
        { xi.item.BONE_PICK,       6776, 2 },
        { xi.item.BRONZE_ZAGHNAL,   357, 3 },
        { xi.item.BRASS_ZAGHNAL,   2938, 3 },
        { xi.item.HARPOON,          112, 3 },
        { xi.item.BRONZE_DAGGER,    162, 3 },
        { xi.item.BRASS_DAGGER,     967, 3 },
        { xi.item.DAGGER,          2111, 3 },
        { xi.item.BILBO,           3634, 3 },
        { xi.item.XIPHOS,           698, 3 },
        { xi.item.SPATHA,          1934, 3 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.TANIKOMANIKO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
