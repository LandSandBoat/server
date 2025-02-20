-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Silke
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        6059, 29925,    -- Animus Augeo Schema
        6060, 29925,    -- Animus Minuo Schema
        6061, 36300     -- Adloquim Schema
    }

    player:showText(npc, ID.text.SILKE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
