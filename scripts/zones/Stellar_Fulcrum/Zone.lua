-----------------------------------
--
-- Zone: Stellar_Fulcrum
--
-----------------------------------
local ID = require("scripts/zones/Stellar_Fulcrum/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
-----------------------------------

function onInitialize(zone)

    zone:registerRegion(1, -522, -2, -49,  -517, -1, -43) -- To Upper Delkfutt's Tower
    zone:registerRegion(2, 318, -3, 2,  322, 1, 6) -- Exit BCNM to ?

end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)

    local cs = -1

    if (player:getCurrentMission(ZILART) == tpz.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER and player:getCharVar("ZilartStatus") == 2) then
        cs = 0
    end

    return cs

end

function onRegionEnter(player, region)

    switch (region:GetRegionID()): caseof
    {
        [1] = function (x)
            player:startEvent(8)
        end,
        [2] = function (x)
            player:startEvent(8)
        end,
    }

end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 8 and option == 1) then
        player:setPos(-370, -178, -40, 243, 158)
    elseif (csid == 0) then
        player:setCharVar("ZilartStatus", 3)
    end

end
