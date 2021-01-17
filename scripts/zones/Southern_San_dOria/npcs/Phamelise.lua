-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Phamelise
-- Zulkheim Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(tpz.region.ZULKHEIM) ~= tpz.nation.SANDORIA then
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
        tpz.shop.general(player, stock, SANDORIA)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
