-----------------------------------
-- Area: Windurst Waters
--  NPC: Baehu-Faehu
-- Only sells when Windurst has control of Sarutabaruta
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local regionOwner = GetRegionOwner(xi.region.SARUTABARUTA)
    if regionOwner ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.BAEHUFAEHU_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.BAEHUFAEHU_OPEN_DIALOG)

        local stock =
        {
            4444,  22,  -- Rarab Tail
            689,   33,  -- Lauan Log
            619,   43,  -- Popoto
            4392,  29,  -- Saruta Orange
            635,   18   -- Windurstian Tea Leaves
        }

        xi.shop.general(player, stock, xi.quest.fame_area.WINDURST)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
