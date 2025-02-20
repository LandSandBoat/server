-----------------------------------
-- Area: Windurst_Woods
--  NPC: Nhobi Zalkia
-- Only sells when Windurst controlls Kuzotz Region
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
    local regionOwner = GetRegionOwner(xi.region.KUZOTZ)

    if regionOwner ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.NHOBI_ZALKIA_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.NHOBI_ZALKIA_OPEN_DIALOG)

        local stock =
        {
            916,   855,  -- Cactuar Needle
            4412,  299,  -- Thundermelon
            4491,  184   -- Watermelon
        }
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end
end

return entity
