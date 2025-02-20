-----------------------------------
-- Area: Bastok Mines
--  NPC: Boytz
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BRASS_FLOWERPOT,      1040, 3,
        xi.item.PICKAXE,               208, 3,
        xi.item.FLASK_OF_EYE_DROPS,   2698, 3,
        xi.item.ANTIDOTE,              328, 3,
        xi.item.FLASK_OF_ECHO_DROPS,   832, 2,
        xi.item.POTION,                946, 2,
        xi.item.ETHER,                5025, 1,
        xi.item.WOODEN_ARROW,            4, 2,
        xi.item.IRON_ARROW,              8, 3,
        xi.item.CROSSBOW_BOLT,           6, 3,
        xi.item.REPUBLIC_WAYSTONE,   10400, 3,
    }

    local rank = GetNationRank(xi.nation.BASTOK)

    if rank >= 2 then
        table.insert(stock, xi.item.SET_OF_THIEFS_TOOLS)
        table.insert(stock, 3643)
        table.insert(stock, 3)
    end

    if rank >= 3 then
        table.insert(stock, xi.item.LIVING_KEY)
        table.insert(stock, 5520)
        table.insert(stock, 3)
    end

    player:showText(npc, ID.text.BOYTZ_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
