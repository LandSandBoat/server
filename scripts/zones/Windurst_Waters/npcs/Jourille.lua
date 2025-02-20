-----------------------------------
-- Area: Windurst Waters
--  NPC: Jourille
-- Only sells when Windurst controlls Ronfaure Region
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

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
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end
end

return entity
