-----------------------------------
--
-- Zone: Bastok_Markets_[S] (87)
--
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
require("scripts/globals/chocobo")
-----------------------------------

function onInitialize(zone)
    tpz.chocobo.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        local position = math.random(1, 5) - 33
        player:setPos(-177, -8, position, 127)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
