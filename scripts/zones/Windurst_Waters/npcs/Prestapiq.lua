-----------------------------------
-- Area: Windurst Waters
--  NPC: Prestapiq
-- Only sells when Windurst controls Movalpolos
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local regionOwner = GetRegionOwner(xi.region.MOVALPOLOS)

    if regionOwner ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.PRESTAPIQ_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.PRESTAPIQ_OPEN_DIALOG)

        local stock =
        {
            640,    11,   --Copper Ore
            4450,   694,   --Coral Fungus
            4375,  4032,   --Danceshroom
            1650,  6500,   --Kopparnickel Ore
            5165,   736    --Movalpolos Water
        }
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end
end

return entity
