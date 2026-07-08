-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Silke
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.ANIMUS_AUGEO_SCHEMA, 29925 },
        { xi.item.ANIMUS_MINUO_SCHEMA, 29925 },
        { xi.item.ADLOQUIUM_SCHEMA,    36300 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS_S].text.SILKE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
