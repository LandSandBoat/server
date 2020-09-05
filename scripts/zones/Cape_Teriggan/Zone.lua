-----------------------------------
--
-- Zone: Cape_Teriggan (113)
--
-----------------------------------
local ID = require("scripts/zones/Cape_Teriggan/IDs")
-----------------------------------
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/conquest")
require("scripts/globals/weather")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    local Kreutzet = GetMobByID(ID.mob.KREUTZET)
    UpdateNMSpawnPoint(ID.mob.KREUTZET)
    Kreutzet:setRespawnTime(math.random(32400, 43200)) -- 9 to 12 hours
    Kreutzet:setLocalVar("cooldown", os.time() + Kreutzet:getRespawnTime()/1000)
    DisallowRespawn(Kreutzet:getID(), true) -- prevents accidental 'pop' during no wind weather and immediate despawn

    tpz.conq.setRegionalConquestOverseers(zone:getRegionID())
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn( player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos( 315.644, -1.517, -60.633, 108)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 2
    end

    return cs
end

function onRegionEnter( player, region)
end

function onEventUpdate( player, csid, option)
    if csid == 2 then
        quests.rainbow.onEventUpdate(player)
    end
end

function onEventFinish( player, csid, option)
end

function onZoneWeatherChange(weather)
    local Kreutzet = GetMobByID(ID.mob.KREUTZET)
    if
        not Kreutzet:isSpawned() and os.time() > Kreutzet:getLocalVar("cooldown")
        and (weather == tpz.weather.WIND or weather == tpz.weather.GALES)
    then
        DisallowRespawn(Kreutzet:getID(), false)
        Kreutzet:setRespawnTime(math.random(30, 150)) -- pop 30-150 sec after wind weather starts
    end
end
