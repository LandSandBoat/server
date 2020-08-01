-----------------------------------
--
-- Zone: Castle_Zvahl_Baileys_[S] (138)
--
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Baileys_[S]/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-181.969, -35.542, 19.995, 254)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
