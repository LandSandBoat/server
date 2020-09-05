-----------------------------------
--
-- Zone: Castle_Zvahl_Keep (162)
--
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Keep/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1, -301, -50, -22, -297, -49, -17) -- central porter on map 3
    zone:registerRegion(2, -275, -54, 3, -271, -53, 7)     -- NE porter on map 3
    zone:registerRegion(3, -275, -54, -47, -271, -53, -42) -- SE porter on map 3
    zone:registerRegion(4, -330, -54, 3, -326, -53, 7)     -- NW porter on map 3
    zone:registerRegion(5, -328, -54, -47, -324, -53, -42) -- SW porter on map 3
    zone:registerRegion(6, -528, -74, 84, -526, -73, 89)   -- N porter on map 4
    zone:registerRegion(7, -528, -74, 30, -526, -73, 36)   -- S porter on map 4

    tpz.treasure.initZone(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-555.996, -71.691, 59.989, 254)
    end
    return cs
end

function onRegionEnter(player, region)

    switch (region:GetRegionID()): caseof
    {
        ---------------------------------
        [1] = function (x)  --
        ---------------------------------
            player:startEvent(0) -- ports player to far NE corner
        end,

        ---------------------------------
        [2] = function (x)  --
        ---------------------------------
            player:startEvent(2) -- ports player to
        end,

        ---------------------------------
        [3] = function (x)  --
        ---------------------------------
            player:startEvent(1) -- ports player to far SE corner
        end,

        ---------------------------------
        [4] = function (x)  --
        ---------------------------------
            player:startEvent(1) -- ports player to far SE corner
        end,

        ---------------------------------
        [5] = function (x)  --
        ---------------------------------
            player:startEvent(5) -- ports player to H-7 on map 4 (south or north part, randomly)
        end,

        ---------------------------------
        [6] = function (x)  --
        ---------------------------------
            player:startEvent(6) -- ports player to position "A" on map 2
        end,

        ---------------------------------
        [7] = function (x)  --
        ---------------------------------
            player:startEvent(7) -- ports player to position G-8 on map 2
        end,

        default = function (x)
            -- print("default")
        end,
    }

end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
