-----------------------------------
-- Area: Windurst Waters
--  NPC: Baehu-Faehu
-- Only sells when Windurst has control of Sarutabaruta
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

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

        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end
end

return entity
