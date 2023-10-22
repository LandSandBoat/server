-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Antonian
-- Regional Marchant NPC
-- Only sells when San d'Oria controlls Aragoneu.
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvest.onHalloweenTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ARAGONEU) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.ANTONIAN_CLOSED_DIALOG)
    else
        local stock =
        {
            631,   36, -- Horo Flour
            629,   44, -- Millioncorn
            4415, 114, -- Roasted Corn
            4505,  92, -- Sunflower Seeds
            841,   36, -- Yagudo Feather
        }

        player:showText(npc, ID.text.ANTONIAN_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.quest.fame_area.SANDORIA)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
