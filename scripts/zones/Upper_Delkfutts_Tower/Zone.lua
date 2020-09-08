-----------------------------------
--
-- Zone: Upper_Delkfutts_Tower (158)
--
-----------------------------------
local ID = require("scripts/zones/Upper_Delkfutts_Tower/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1, -369, -146, 83,  -365, -145,  89) -- Tenth Floor F-6 porter to Middle Delkfutt's Tower
    zone:registerRegion(2, -369, -178, -49, -365, -177, -43) -- Twelfth Floor F-10 porter to Stellar Fulcrum

    tpz.treasure.initZone(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(12.098, -105.408, 27.683, 239)
    end
    return cs
end

function onRegionEnter(player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function (x)
            --player:setCharVar("porter_lock", 1)
            player:startEvent(0)
        end,
        [2] = function (x)
            --player:setCharVar("porter_lock", 1)
            player:startEvent(1)
        end,
    }
end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 0 and option == 1 then
        player:setPos(-490, -130, 81, 231, 157)
    elseif csid == 1 and option == 1 then
        player:setPos(-520 , 1 , -23, 192, 179) -- to Stellar Fulcrum
    end
end
