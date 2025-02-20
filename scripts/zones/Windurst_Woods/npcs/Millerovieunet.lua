-----------------------------------
-- Area: Windurst_Woods
--  NPC: Millerovieunet
-- Only sells when Windurst controlls Qufim Region
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
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
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end
end

return entity
