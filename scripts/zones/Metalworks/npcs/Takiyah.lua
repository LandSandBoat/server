-----------------------------------
-- Area: Metalworks
--  NPC: Takiyah
-- Type: Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.QUFIMISLAND) ~= tpz.nation.BASTOK then
        player:showText(npc, ID.text.TAKIYAH_CLOSED_DIALOG)
    else
        local stock =
        {
            954, 4121,    -- Magic Pot Shard
        }

        player:showText(npc, ID.text.TAKIYAH_OPEN_DIALOG)
        tpz.shop.general(player, stock, BASTOK)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
