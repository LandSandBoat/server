-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Blingbrix
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HI_POTION,  4500 },
        { xi.item.HI_ETHER,  28000 },
        { xi.item.PICKAXE,     200 },
        { xi.item.SICKLE,      300 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS_S].text.BLINGBRIX_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
