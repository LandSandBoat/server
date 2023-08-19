-----------------------------------
-- Area: Windurst Waters
--  NPC: Jourille
-- Only sells when Windurst controlls Ronfaure Region
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local regionOwner = GetRegionOwner(xi.region.RONFAURE)
    if regionOwner ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.JOURILLE_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.JOURILLE_OPEN_DIALOG)

        local stock =
        {
            639,   110,  -- Chestnut
            4389,   29,  -- San d'Orian Carrot
            610,    55,  -- San d'Orian Flour
            4431,   69,  -- San d'Orian Grape
        }
        xi.shop.general(player, stock, xi.quest.fame_area.WINDURST)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
