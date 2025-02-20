-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Phamelise
-- Zulkheim Regional Merchant
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ZULKHEIM) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.PHAMELISE_CLOSED_DIALOG)
    else
        local stock =
        {
            4372,   44,    -- Giant Sheep Meat
            622,    44,    -- Dried Marjoram
            610,    55,    -- San d'Orian Flour
            611,    36,    -- Rye Flour
            1840, 1840,    -- Semolina
            4366,   22,    -- La Theine Cabbage
            4378,   55,    -- Selbina Milk
        }

        player:showText(npc, ID.text.PHAMELISE_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
