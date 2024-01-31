-----------------------------------
-- Zone: Western_Altepa_Desert (125)
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
require('scripts/quests/i_can_hear_a_rainbow')
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

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 2 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
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

zoneObject.afterZoneIn = function(player)
    -- Send players who zone in an update for the Altepa Gate "doors" so you can see the state from further away
    -- TODO: these NPCs should be "permanently" in the NPC spawn list for all players -- there's a bug if you get too close and move away they revert to the "needs to be opened" state.
    -- This currently acts as a small QoL from a long distance, better than nothing, but closer to retail.
    for i = ID.npc.ALTEPA_GATE, ID.npc.ALTEPA_GATE + 8 do
        player:sendEntityUpdateToPlayer(GetNPCByID(i), xi.entityUpdate.ENTITY_UPDATE, xi.updateType.UPDATE_COMBAT)
    end
end

return zoneObject
