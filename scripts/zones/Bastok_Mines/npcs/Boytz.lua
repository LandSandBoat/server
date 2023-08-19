-----------------------------------
-- Area: Bastok Mines
--  NPC: Boytz
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.BRASS_FLOWERPOT,      1040, 3,
        xi.items.PICKAXE,               208, 3,
        xi.items.FLASK_OF_EYE_DROPS,   2698, 3,
        xi.items.ANTIDOTE,              328, 3,
        xi.items.FLASK_OF_ECHO_DROPS,   832, 2,
        xi.items.POTION,                946, 2,
        xi.items.ETHER,                5025, 1,
        xi.items.WOODEN_ARROW,            4, 2,
        xi.items.IRON_ARROW,              8, 3,
        xi.items.CROSSBOW_BOLT,           6, 3,
        xi.items.REPUBLIC_WAYSTONE,   10400, 3,
    }

    local rank = GetNationRank(xi.nation.BASTOK)

    if rank >= 2 then
        table.insert(stock, xi.items.SET_OF_THIEFS_TOOLS)
        table.insert(stock, 3643)
        table.insert(stock, 3)
    end

    if rank >= 3 then
        table.insert(stock, xi.items.LIVING_KEY)
        table.insert(stock, 5520)
        table.insert(stock, 3)
    end

    player:showText(npc, ID.text.BOYTZ_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
