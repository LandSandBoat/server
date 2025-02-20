-----------------------------------
-- Area: Windurst_Waters
--  NPC: Otete
-- Only sells when Windurst controlls Li'Telor Region
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local regionOwner = GetRegionOwner(xi.region.LITELOR)

    if regionOwner ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.OTETE_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.OTETE_OPEN_DIALOG)

        local stock =
        {
            623,    119, -- Bay Leaves
            4154,  6440  -- Holy Water
        }
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end
end

return entity
