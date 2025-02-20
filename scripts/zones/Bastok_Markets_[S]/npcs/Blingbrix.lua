-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Blingbrix
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4116,  4500,    --Hi-Potion
        4132, 28000,    --Hi-Ether
        605,    200,    --Pickaxe
        1020,   300     --Sickle
    }

    player:showText(npc, ID.text.BLINGBRIX_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
