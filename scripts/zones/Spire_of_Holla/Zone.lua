-----------------------------------
--
-- Zone: Spire_of_Holla (17)
--
-----------------------------------
local ID = require("scripts/zones/Spire_of_Holla/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(1.460, -2.050, -293.738, 191) -- {R}
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
