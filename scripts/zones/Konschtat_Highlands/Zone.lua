-----------------------------------
-- Zone: Konschtat_Highlands (108)
-----------------------------------
local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
require('scripts/quests/i_can_hear_a_rainbow')
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

    if quests.rainbow.onZoneIn(player) then
        cs = 104
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
    if csid == 104 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onGameHour = function(zone)
    local hour = VanadielHour()

    if hour < 5 or hour >= 17 then
        local phase = VanadielMoonPhase()
        local haty = GetMobByID(ID.mob.HATY)
        local vran = GetMobByID(ID.mob.BENDIGEIT_VRAN)
        local time = os.time()

        if
            haty and
            phase >= 90 and
            not haty:isSpawned() and
            time > haty:getLocalVar('cooldown')
        then
            SpawnMob(ID.mob.HATY)
        elseif
            vran and
            phase <= 10 and
            not vran:isSpawned() and
            time > vran:getLocalVar('cooldown')
        then
            SpawnMob(ID.mob.BENDIGEIT_VRAN)
        end
    end
end

return zoneObject
