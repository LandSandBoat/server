-----------------------------------
-- Area: Bastok_Mines
--  NPC: Mille
-- Norvallen Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvest.onHalloweenTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.NORVALLEN) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.MILLE_CLOSED_DIALOG)
    else
        local stock =
        {
            688, 18,    -- Arrowwood Log
            698, 88,    -- Ash Log
            618, 25,    -- Blue Peas
            621, 25,     -- Crying Mustard
        }

        player:showText(npc, ID.text.MILLE_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.quest.fame_area.BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
