-----------------------------------
--
-- Zone: Fort_Karugo-Narugo_[S] (96)
--
-----------------------------------
local ID = require("scripts/zones/Fort_Karugo-Narugo_[S]/IDs")
require("scripts/globals/status")
require("scripts/globals/helm")
-----------------------------------

function onInitialize(zone)
    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(820, 25.782, 117.991, 66)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onZoneWeatherChange(weather)
    npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS)
    if (npc ~= nil) then
        if (weather == tpz.weather.DUST_STORM or weather == tpz.weather.SAND_STORM) then
            npc:setStatus(tpz.status.DISAPPEAR)
        else
            npc:setStatus(tpz.status.NORMAL)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
