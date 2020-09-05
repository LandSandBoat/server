-----------------------------------
--
-- Zone: Grand_Palace_of_HuXzoi (34)
--
-----------------------------------
require("scripts/zones/Grand_Palace_of_HuXzoi/globals")
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/globals/conquest")
require("scripts/globals/status")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion( 1, -507, -4, 697, -501, 4, 702)
    zone:registerRegion( 2, -102, -4, 541,  -97, 4, 546)
    zone:registerRegion( 3, -178, -4,  97, -173, 4, 103)
    zone:registerRegion( 4, -497, -4,  97, -492, 4, 102)
    zone:registerRegion( 5, -742, -4, 372, -736, 4, 379)
    zone:registerRegion( 6,  332, -4, 696,  338, 4, 702)
    zone:registerRegion( 7,  737, -4, 541,  742, 4, 546)
    zone:registerRegion( 8,  661, -4,  87,  667, 4, 103)
    zone:registerRegion( 9,  340, -4,  97,  347, 4, 102)
    zone:registerRegion(10,   97, -4, 372,  103, 4, 378)

    GRAND_PALACE_OF_HUXZOI.pickTemperancePH()
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-20, -1.5, -355.482, 192)
    end

    player:setCharVar("Hu-Xzoi-TP", 0)

    return cs
end

function afterZoneIn(player)
    player:entityVisualPacket("door")
    player:entityVisualPacket("dtuk")
    player:entityVisualPacket("2dor")
    player:entityVisualPacket("cryq")
end

function onRegionEnter(player, region)
    if (player:getCharVar("Hu-Xzoi-TP") == 0 and player:getAnimation() == tpz.anim.NONE) then -- prevent 2cs at same time
        player:startEvent(149 + region:GetRegionID())
    end
end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
    if (csid >= 150 and csid <= 159) then
        player:setCharVar("Hu-Xzoi-TP", 1)
    end
end

function onEventFinish(player, csid, option)
    if (csid >= 150 and csid <= 159) then
        player:setCharVar("Hu-Xzoi-TP", 0)
    end
end

function onGameHour(zone)
end
