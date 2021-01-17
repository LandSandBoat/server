-----------------------------------
-- Area: Bastok Markets
--  NPC: Oggodett
-- Aragoneu Regional Goods
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(tpz.region.ARAGONEU) ~= tpz.nation.BASTOK then
        player:showText(npc, ID.text.OGGODETT_CLOSED_DIALOG)
    else
        local stock =
        {
            631,    36,    -- Horo Flour
            629,    43,    -- Millioncorn
            4415,  111,    -- Roasted Corn
            4505,   90,    -- Sunflower Seeds
            841,    36,     -- Yagudo Feather
        }

        player:showText(npc, ID.text.OGGODETT_OPEN_DIALOG)
        tpz.shop.general(player, stock, BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
