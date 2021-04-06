-----------------------------------
--
-- Zone: Konschtat_Highlands (108)
--
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/chocobo")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    xi.chocobo.initZone(zone)
    xi.voidwalker.zoneOnInit(zone)
end

zone_object.onZoneIn = function( player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(521.922, 28.361, 747.85, 45)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 104
    elseif player:getCurrentMission(WINDURST) == xi.mission.id.windurst.VAIN and player:getMissionStatus(player:getNation()) == 1 then
        cs = 106
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function( player, region)
end

zone_object.onEventUpdate = function( player, csid, option)
    if csid == 104 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 106 then
        if player:getZPos() > 855 then
            player:updateEvent(0, 0, 0, 0, 0, 2)
        elseif player:getXPos() > 32 and player:getXPos() < 370 then
            player:updateEvent(0, 0, 0, 0, 0, 1)
        end
    end
end

zone_object.onEventFinish = function( player, csid, option)
end

zone_object.onGameHour = function(zone)
    local hour = VanadielHour()

    if hour < 5 or hour >= 17 then
        local phase = VanadielMoonPhase()
        local haty = GetMobByID(ID.mob.HATY)
        local vran = GetMobByID(ID.mob.BENDIGEIT_VRAN)
        local time = os.time()

        if phase >= 90 and not haty:isSpawned() and time > haty:getLocalVar("cooldown") then
            SpawnMob(ID.mob.HATY)
        elseif phase <= 10 and not vran:isSpawned() and time > vran:getLocalVar("cooldown") then
            SpawnMob(ID.mob.BENDIGEIT_VRAN)
        end
    end
end

return zone_object
