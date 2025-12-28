-----------------------------------
-- Zone: Konschtat_Highlands (108)
-----------------------------------
local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
require('scripts/missions/amk/helpers')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.chocobo.initZone(zone)
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-193, 71, 842, 117)
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
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onGameHour = function(zone)
    local hour = VanadielHour()

    if hour < 5 or hour >= 17 then
        local moonCycle = getVanadielMoonCycle()
        local haty = GetMobByID(ID.mob.HATY)
        local vran = GetMobByID(ID.mob.BENDIGEIT_VRAN)
        local time = GetSystemTime()

        if
            haty and
            moonCycle == xi.moonCycle.FULL_MOON and
            not haty:isSpawned() and
            time > haty:getLocalVar('cooldown')
        then
            SpawnMob(ID.mob.HATY)
        elseif
            vran and
            moonCycle == xi.moonCycle.NEW_MOON and
            not vran:isSpawned() and
            time > vran:getLocalVar('cooldown')
        then
            SpawnMob(ID.mob.BENDIGEIT_VRAN)
        end
    end
end

return zoneObject
