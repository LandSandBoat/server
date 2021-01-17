-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Millechuca
-- Regional Marchant NPC
-- Only sells when San d'Oria controls Vollbow.
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(tpz.region.VOLLBOW) ~= tpz.nation.SANDORIA then
        player:showText(npc, ID.text.MILLECHUCA_CLOSED_DIALOG)
    else
        local stock =
        {
            636,   119,    -- Chamomile
            864,    88,    -- Fish Scales
            936,    14,    -- Rock Salt
            1410, 1656,    -- Sweet William
        }

        player:showText(npc, ID.text.MILLECHUCA_OPEN_DIALOG)
        tpz.shop.general(player, stock, SANDORIA)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
