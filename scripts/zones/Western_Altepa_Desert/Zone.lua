-----------------------------------
-- Zone: Western_Altepa_Desert (125)
-----------------------------------
local ID = require('scripts/zones/Western_Altepa_Desert/IDs')
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
    DisallowRespawn(GetMobByID(ID.mob.KING_VINEGARROON):getID(), true)

    if os.time() < GetServerVariable("\\[SPAWN\\]17289575") then
        GetMobByID(ID.mob.KING_VINEGARROON):setRespawnTime(GetServerVariable("\\[SPAWN\\]17289575") - os.time())
    end

    xi.bmt.updatePeddlestox(xi.zone.YUHTUNGA_JUNGLE, ID.npc.PEDDLESTOX)
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

    local kingV = GetMobByID(ID.mob.KING_VINEGARROON)
    local kvre = GetServerVariable("\\[SPAWN\\]17289575")
    if
        not kingV:isSpawned() and
        os.time() > kvre and
        weather == xi.weather.DUST_STORM
    then
        -- 10% chance for KV pop at start of single earth weather
        local chance = math.random(1, 10)
        if chance == 1 then
            DisallowRespawn(kingV:getID(), false)
            SpawnMob(ID.mob.KING_VINEGARROON)
        end
    elseif
        not kingV:isSpawned() and
        os.time() > kvre and
        weather == xi.weather.SAND_STORM
    then
        DisallowRespawn(kingV:getID(), false)
        SpawnMob(ID.mob.KING_VINEGARROON)
    end
end

return zoneObject
