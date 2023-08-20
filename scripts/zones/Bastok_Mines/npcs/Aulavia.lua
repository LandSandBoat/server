-----------------------------------
-- Area: Bastok Mines
--  NPC: Aulavia
-- Vollbow Regional Merchant
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.VOLLBOW) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.AULAVIA_CLOSED_DIALOG)
    else
        local stock =
        {
            636,   119,    -- Chamomile
            864,    88,    -- Fish Scales
            936,    14,    -- Rock Salt
            1410, 1656,     -- Sweet William
        }

        player:showText(npc, ID.text.AULAVIA_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.quest.fame_area.BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
