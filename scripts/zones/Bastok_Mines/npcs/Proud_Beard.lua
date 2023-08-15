-----------------------------------
-- Area: Bastok Mines
--  NPC: Proud Beard
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.HUME_TUNIC,       312,
        xi.items.HUME_VEST,        312,
        xi.items.HUME_M_GLOVES,    187,
        xi.items.HUME_F_GLOVES,    187,
        xi.items.HUME_SLACKS,      270,
        xi.items.HUME_PANTS,       270,
        xi.items.HUME_M_BOOTS,     187,
        xi.items.HUME_F_BOOTS,     187,
        xi.items.GALKAN_SURCOAT,   312,
        xi.items.GALKAN_BRACERS,   187,
        xi.items.GALKAN_BRAGUETTE, 270,
        xi.items.GALKAN_SANDALS,   187,
    }

    player:showText(npc, ID.text.PROUDBEARD_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
