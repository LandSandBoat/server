-----------------------------------
--
-- Zone: Rolanberry_Fields_[S] (91)
--
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields_[S]/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-376.179, -30.387, -776.159, 220)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
