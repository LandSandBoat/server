-----------------------------------
-- Zone: Western_Altepa_Desert (125)
-----------------------------------
local ID = require('scripts/zones/Western_Altepa_Desert/IDs')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/zone')
require('scripts/globals/beastmentreasure')
require('scripts/missions/amk/helpers')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.KING_VINEGARROON)
    GetMobByID(ID.mob.KING_VINEGARROON):setRespawnTime(math.random(900, 10800))

    xi.bmt.updatePeddlestox(xi.zone.YUHTUNGA_JUNGLE, ID.npc.PEDDLESTOX)
end

zoneObject.onGameDay = function()
    xi.bmt.updatePeddlestox(xi.zone.WESTERN_ALTEPA_DESERT, ID.npc.PEDDLESTOX)
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
    local kvMob = GetMobByID(ID.mob.KING_VINEGARROON)

    if
        kvMob:getCurrentAction() == xi.act.DESPAWN and
        (weather == xi.weather.DUST_STORM or weather == xi.weather.SAND_STORM)
    then
        kvMob:spawn()
    elseif
        kvMob:getCurrentAction() == xi.act.ROAMING and
        weather ~= xi.weather.DUST_STORM and
        weather ~= xi.weather.SAND_STORM
    then
        DespawnMob(ID.mob.KING_VINEGARROON)
    end
end

return zoneObject
