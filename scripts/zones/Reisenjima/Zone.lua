-----------------------------------
--
-- Zone: Reisenjima (291)
--
-----------------------------------
local ID = require("scripts/zones/Reisenjima/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-500.023, -19.074, -487.686, 190)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
