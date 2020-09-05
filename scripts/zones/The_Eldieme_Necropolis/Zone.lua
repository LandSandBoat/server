-----------------------------------
--
-- Zone: The Eldieme Necropolis (195)
--
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
-----------------------------------

function onInitialize(zone)
    tpz.treasure.initZone(zone)
end

function onZoneIn(player, prevZone)
    -- rng af2
    if player:getCharVar("fireAndBrimstone") == 2 then
        return 4
    end

    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-438.878, -26.091, 540.004, 126)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 4 then
        player:setCharVar("fireAndBrimstone", 3)
    end
end
