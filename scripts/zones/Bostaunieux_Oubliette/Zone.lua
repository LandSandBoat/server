-----------------------------------
-- Zone: Bostaunieux_Oubliette (167)
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.DREXERION_THE_CONDEMNED)
    GetMobByID(ID.mob.DREXERION_THE_CONDEMNED):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.PHANDURON_THE_CONDEMNED)
    GetMobByID(ID.mob.PHANDURON_THE_CONDEMNED):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.BLOODSUCKER)
    GetMobByID(ID.mob.BLOODSUCKER):setRespawnTime(3600)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(99.978, -25.647, 72.867, 61)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onGameHour = function(zone)
    -- Don't allow Manes or Shii to spawn outside of night
    if VanadielHour() >= 6 and VanadielHour() < 18 then
        DisallowRespawn(ID.mob.MANES, true)
        DisallowRespawn(ID.mob.SHII, true)
    else
        DisallowRespawn(ID.mob.MANES, false)
        DisallowRespawn(ID.mob.SHII, false)
    end
end

return zoneObject
