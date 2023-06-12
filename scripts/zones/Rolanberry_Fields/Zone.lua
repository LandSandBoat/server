-----------------------------------
-- Zone: Rolanberry_Fields (110)
-----------------------------------
local ID = require('scripts/zones/Rolanberry_Fields/IDs')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/missions')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.SIMURGH)

    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneTick = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(339, 23, 607, 93)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 2
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameHour = function(zone)
    -- Silk Caterpillar should spawn every 6 hours from 03:00
    -- this is approximately when the Jeuno-Bastok airship is flying overhead towards Jeuno.
    if
        VanadielHour() % 6 == 3 and
        not GetMobByID(ID.mob.SILK_CATERPILLAR):isSpawned()
    then
        -- Despawn set to 210 seconds (3.5 minutes, approx when the Jeuno-Bastok airship is flying back over to Bastok).
        SpawnMob(ID.mob.SILK_CATERPILLAR, 210)
    end

    -- Don't allow Black Triple Stars to spawn if its daytime
    if VanadielHour() >= 6 and VanadielHour() < 18 then
        DisallowRespawn(ID.mob.BLACK_TRIPLE_STARS_1, true)
        DisallowRespawn(ID.mob.BLACK_TRIPLE_STARS_2, true)
    else
        DisallowRespawn(ID.mob.BLACK_TRIPLE_STARS_1, false)
        DisallowRespawn(ID.mob.BLACK_TRIPLE_STARS_2, false)
    end
end

zoneObject.onGameDay = function()
    SetServerVariable("[DIG]ZONE110_ITEMS", 0)
end

zoneObject.onEventUpdate = function(player, csid, option)
    if csid == 2 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
