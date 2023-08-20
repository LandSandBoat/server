-----------------------------------
-- Area: Windurst_Woods
--  NPC: Millerovieunet
-- Only sells when Windurst controlls Qufim Region
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.QUFIMISLAND) ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.MILLEROVIEUNET_CLOSED_DIALOG)
    else
        local stock =
        {
            954,  4032  -- Magic Pot Shard
        }

        player:showText(npc, ID.text.MILLEROVIEUNET_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.quest.fame_area.WINDURST)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
