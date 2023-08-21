-----------------------------------
-- Area: Port Bastok
--  NPC: Rosswald
-- Zulkheim Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ZULKHEIM) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.ROSSWALD_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.items.SLICE_OF_GIANT_SHEEP_MEAT,   49,
            xi.items.PINCH_OF_DRIED_MARJORAM,     49,
            xi.items.BAG_OF_SAN_DORIAN_FLOUR,     62,
            xi.items.BAG_OF_RYE_FLOUR,            41,
            xi.items.BAG_OF_SEMOLINA,           2080,
            xi.items.LA_THEINE_CABBAGE,           24,
            xi.items.JUG_OF_SELBINA_MILK,         62,
        }

        player:showText(npc, ID.text.ROSSWALD_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.quest.fame_area.BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
