-----------------------------------
-- Zone: Western_Altepa_Desert (125)
-----------------------------------
local ID = require('scripts/zones/Western_Altepa_Desert/IDs')
require('scripts/globals/events/sunbreeze_festival')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/world')
require('scripts/globals/zone')
require('scripts/globals/beastmentreasure')
require('scripts/missions/amk/helpers')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    -- KV Persistence
    UpdateNMSpawnPoint(ID.mob.KING_VINEGARROON)

    if os.time() < GetServerVariable("\\[SPAWN\\]" .. tostring(ID.mob.KING_VINEGARROON)) then
        GetMobByID(ID.mob.KING_VINEGARROON):setRespawnTime(GetServerVariable("\\[SPAWN\\]" .. tostring(ID.mob.KING_VINEGARROON)) - os.time())
    end

    -- need DisallowRespawn after setRespawnTime because setRespawnTime sets allowRespawn to true
    DisallowRespawn(ID.mob.KING_VINEGARROON, true)

    xi.bmt.updatePeddlestox(xi.zone.YUHTUNGA_JUNGLE, ID.npc.PEDDLESTOX)
end

zoneObject.onGameHour = function(zone)
    xi.events.sunbreeze_festival.spawnFireworks(zone)
end

zoneObject.onGameDay = function()
    xi.bmt.updatePeddlestox(xi.zone.WESTERN_ALTEPA_DESERT, ID.npc.PEDDLESTOX)

    -- Chocobo Digging.
    SetServerVariable("[DIG]ZONE125_ITEMS", 0)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-19.901, 13.607, 440.058, 78)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 2
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
    if csid == 2 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option)
end

zoneObject.onZoneWeatherChange = function(weather)
    if xi.settings.main.ENABLE_WOTG == 1 then
        local dahu = GetMobByID(ID.mob.DAHU)
        if
            not dahu:isSpawned() and os.time() > dahu:getLocalVar("cooldown") and
            (weather == xi.weather.DUST_STORM or weather == xi.weather.SAND_STORM)
        then
            DisallowRespawn(dahu:getID(), false)
            dahu:setRespawnTime(math.random(30, 150)) -- pop 30-150 sec after earth weather starts
        end
    end

    local zone = GetZone(xi.zone.WESTERN_ALTEPA_DESERT)
    if
        weather == xi.weather.DUST_STORM or
        weather == xi.weather.SAND_STORM
    then
        zone:setLocalVar("NeedToCheckKV", 1)
    else
        zone:setLocalVar("NeedToCheckKV", 0)
    end
end

zoneObject.onZoneTick = function(zone)
    -- Need to check KV because of weather
    if zone:getLocalVar("NeedToCheckKV") == 1 then
        local kvre = GetServerVariable("\\[SPAWN\\]" .. tostring(ID.mob.KING_VINEGARROON))
        -- Cannot set NeedToCheckKV to 0 until after this condition
        -- in case window opens during this weather
        if os.time() > kvre then
            local weather = zone:getWeather()
            local kingV = GetMobByID(ID.mob.KING_VINEGARROON)

            if
                not kingV:isSpawned() and
                weather == xi.weather.DUST_STORM
            then
                -- 10% chance for KV pop at start of single earth weather
                local chance = math.random(1, 10)
                if chance == 1 then
                    DisallowRespawn(ID.mob.KING_VINEGARROON, false)
                    SpawnMob(ID.mob.KING_VINEGARROON)
                end
            elseif
                not kingV:isSpawned() and
                weather == xi.weather.SAND_STORM
            then
                DisallowRespawn(ID.mob.KING_VINEGARROON, false)
                SpawnMob(ID.mob.KING_VINEGARROON)
            end

            -- did a full check during this weather
            zone:setLocalVar("NeedToCheckKV", 0)
        end
    end
end

return zoneObject
