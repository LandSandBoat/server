-----------------------------------
-- Area: Windurst_Woods
--  NPC: Bin Stejihna
-- Only sells when Windurst controlls Zulkheim Region
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local regionOwner = GetRegionOwner(xi.region.ZULKHEIM)

    if regionOwner ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.BIN_STEJIHNA_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.BIN_STEJIHNA_OPEN_DIALOG)

        local stock =
        {
            1840,  1840,  -- Semolina
            4372,    44,  -- Giant Sheep Meat
            622,     44,  -- Dried Marjoram
            610,     55,  -- San d'Orian Flour
            611,     36,  -- Rye Flour
            4366,    22,  -- La Theine Cabbage
            4378,    55   -- Selbina Milk
        }

        local rank = GetNationRank(xi.nation.WINDURST)
        if rank ~= 3 then
            table.insert(stock, 1840) --Semolina
            table.insert(stock, 1840)
        end

        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end
end

return entity
