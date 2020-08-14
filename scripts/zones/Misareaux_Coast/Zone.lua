-----------------------------------
--
-- Zone: Misareaux_Coast (25)
--
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/helm")
local ID = require("scripts/zones/Misareaux_Coast/IDs")
local MISAREAUX_COAST = require("scripts/zones/Misareaux_Coast/globals")
-----------------------------------

function onInitialize(zone)
    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
    MISAREAUX_COAST.ziphiusHandleQM()
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(567.624, -20, 280.775, 120)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onGameHour(zone)
    local vHour = VanadielHour()
    if vHour >= 22 or vHour <= 7 then
        MISAREAUX_COAST.ziphiusHandleQM()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
