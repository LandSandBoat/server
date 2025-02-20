-----------------------------------
-- Zone: Valkurm_Dunes (103)
-----------------------------------
local ID = zones[xi.zone.VALKURM_DUNES]
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/missions/amk/helpers')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.conquest.setRegionalConquestOverseers(zone:getRegionID())
    xi.mogTablet.onZoneInitialize(zone)

    local results = zone:queryEntitiesByName('qm2')
    if results ~= nil and results[1] ~= nil then
        local qm2 = results[1]

        if VanadielHour() < 5 or VanadielHour() >= 18 then
            qm2:setStatus(xi.status.NORMAL)
        else
            qm2:setStatus(xi.status.DISAPPEAR)
        end
    end
end

zoneObject.onZoneTick = function(zone)
    xi.mogTablet.onZoneTick(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(60.989, -4.898, -151.001, 198)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 3
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    xi.chocoboGame.handleMessage(player)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 3 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onGameHour = function(zone)
    local results = zone:queryEntitiesByName('qm2')
    if results ~= nil and results[1] ~= nil then
        local qm2 = results[1]
        if VanadielHour() == 5 then
            qm2:setStatus(xi.status.DISAPPEAR)
        end

        if VanadielHour() == 18 then
            qm2:setStatus(xi.status.NORMAL)
        end
    end
end

zoneObject.onZoneWeatherChange = function(weather)
    local qm1 = GetNPCByID(ID.npc.SUNSAND_QM) -- Quest: An Empty Vessel

    if qm1 then
        if weather == xi.weather.DUST_STORM then
            qm1:setStatus(xi.status.NORMAL)
        else
            qm1:setStatus(xi.status.DISAPPEAR)
        end
    end
end

return zoneObject
