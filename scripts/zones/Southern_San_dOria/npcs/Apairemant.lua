-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Apairemant
-- Gustaberg Regional Merchant
-- !pos 72 2 0 230
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
    if GetRegionOwner(tpz.region.GUSTABERG) ~= tpz.nation.SANDORIA then
        player:showText(npc, ID.text.APAIREMANT_CLOSED_DIALOG)
    else
        local stock =
        {
            1108, 703,    -- Sulfur
            619,   43,    -- Popoto
            611,   36,    -- Rye Flour
            4388,  40,    -- Eggplant
        }

        player:showText(npc, ID.text.APAIREMANT_OPEN_DIALOG)
        tpz.shop.general(player, stock, SANDORIA)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
