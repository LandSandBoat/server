-----------------------------------
-- Zone: Ship_bound_for_Selbina (220)
-----------------------------------
local ID = require('scripts/zones/Ship_bound_for_Selbina/IDs')
require('scripts/globals/sea_creatures')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1
    local zoneID = 220

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.random(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
    end

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.random(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
        if
            player:getGMLevel() == 0 and
            GetZone(zoneID):getLocalVar('stateSet') == 0
        then
            GetZone(zoneID):setLocalVar('stateSet', 1)
            GetZone(zoneID):setLocalVar('state', 2)
            GetZone(zoneID):setLocalVar('transportTime', os.time())
        end
    end

    return cs
end

zoneObject.onGameHour = function(zone)
    local hour = VanadielHour()
    if hour >= 20 or hour < 4 then
        -- Check for Enagakure
        local players = zone:getPlayers()
        for _, player in pairs(players) do
            if
                player:hasKeyItem(xi.ki.SEANCE_STAFF) and
                player:getVar("Quest[5][144]nmKilled") == 0 and
                not GetMobByID(ID.mob.ENAGAKURE):isSpawned()
            then
                GetMobByID(ID.mob.ENAGAKURE):spawn()
            end
        end

        if
            math.random() < 0.20 and
            not GetMobByID(ID.mob.PHANTOM):isSpawned()
        then
            GetMobByID(ID.mob.PHANTOM):spawn()
        end

    else
        if GetMobByID(ID.mob.PHANTOM):isSpawned() then
            DespawnMob(ID.mob.PHANTOM)
        end

        if GetMobByID(ID.mob.ENAGAKURE):isSpawned() then
            DespawnMob(ID.mob.ENAGAKURE)
        end
    end

    local mob = GetMobByID(ID.mob.SEA_HORROR)
    -- 3% chance per game hour (if not spawned, and min repop time)
    if
        math.random(0, 100) < 3 and
        not mob:isSpawned() and
        os.time() > mob:getLocalVar("respawnTime")
    then
        mob:spawn()
    end
end

zoneObject.onZoneTick = function(zone)
    if zone:getLocalVar('state') == 1 then
        if GetMobByID(ID.mob.PHANTOM):isSpawned() then
            DespawnMob(ID.mob.PHANTOM)
        end

        if GetMobByID(ID.mob.SEA_HORROR):isSpawned() then
            DespawnMob(ID.mob.SEA_HORROR)
        end

        xi.sea_creatures.despawn(ID)
        zone:setLocalVar('state', 0)

    elseif zone:getLocalVar('state') == 2 then
        if GetMobByID(ID.mob.SEA_HORROR):isSpawned() then -- make sure we dont have horror from previous or docked zone
            DespawnMob(ID.mob.SEA_HORROR)
        end

        xi.sea_creatures.checkSpawns(ID, 5, 1) -- 5 percent on init
        zone:setLocalVar('state', 0)
    end

    if os.time() - zone:getLocalVar('transportTime') % 60 then
        xi.sea_creatures.checkSpawns(ID, 1, 2) -- 1 percent per vana minute, 2 total mobs
    end
end

zoneObject.onTransportEvent = function(player, transport)
    player:getZone():setLocalVar('stateSet', 0)
    player:getZone():setLocalVar('state', 1)
    player:startEvent(255)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 255 then
        player:setPos(0, 0, 0, 0, 248)
    end
end

return zoneObject
