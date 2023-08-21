-----------------------------------
-- Area: Port Bastok
--  NPC: Evelyn
-- Gustaberg Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.GUSTABERG) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.EVELYN_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.item.PINCH_OF_SULFUR,  795,
            xi.item.POPOTO,            49,
            xi.item.BAG_OF_RYE_FLOUR,  41,
            xi.item.EGGPLANT,          45,
        }

        player:showText(npc, ID.text.EVELYN_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.quest.fame_area.BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
