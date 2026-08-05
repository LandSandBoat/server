-----------------------------------
-- Area: Port Windurst
--  NPC: Taniko-Maniko
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.CAT_BAGHNAKHS,    116, 3 },
        { xi.item.CESTI,            144, 3 },
        { xi.item.BRASS_KNUCKLES,   900, 3 },
        { xi.item.BRASS_BAGHNAKHS, 1690, 3 },
        { xi.item.BONE_AXE,        4665, 3 },
        { xi.item.BONE_PICK,       6516, 2 },
        { xi.item.BRONZE_ZAGHNAL,   344, 3 },
        { xi.item.BRASS_ZAGHNAL,   2825, 3 },
        { xi.item.HARPOON,          108, 3 },
        { xi.item.BRONZE_DAGGER,    156, 3 },
        { xi.item.BRASS_DAGGER,     930, 3 },
        { xi.item.DAGGER,          2030, 3 },
        { xi.item.BILBO,           3495, 3 },
        { xi.item.XIPHOS,           672, 3 },
        { xi.item.SPATHA,          1860, 3 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.TANIKOMANIKO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
