-----------------------------------
--
-- Zone: Ship_bound_for_Mhaura (221)
--
-----------------------------------
local ID = require("scripts/zones/Ship_bound_for_Mhaura/IDs")
require("scripts/globals/sea_creatures")
-----------------------------------
local zone_object = {}

local function spawnBoatMob(mob)
    mob:spawn()
    mob:setLocalVar("maxVerticalAggro", 4)
end

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone, zone)
    local cs = -1
    local zoneID = 221

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        local position = math.random(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
        if player:getGMLevel() == 0 and GetZone(zoneID):getLocalVar('stateSet') == 0 then
            GetZone(zoneID):setLocalVar('stateSet', 1)
            GetZone(zoneID):setLocalVar('state', 2)
            GetZone(zoneID):setLocalVar('transportTime', os.time())
        end
    end
    return cs
end

zone_object.onTransportEvent = function(player, transport)
    player:startEvent(512)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onGameHour = function()
    local hour = VanadielHour()
    if hour >= 20 or hour < 4 then
        if math.random() < 0.20 and not GetMobByID(ID.mob.PHANTOM):isSpawned() then
            spawnBoatMob(GetMobByID(ID.mob.PHANTOM))
        end
    elseif GetMobByID(ID.mob.PHANTOM):isSpawned() then
        DespawnMob(ID.mob.PHANTOM)
    end

    local mob = GetMobByID(ID.mob.SEA_HORROR)
    -- 3% chance per game hour (if not spawned, and min repop time)
    if math.random(0, 100) < 3 and not mob:isSpawned() and os.time() > mob:getLocalVar("respawnTime") then
        spawnBoatMob(mob)
    end
end

zone_object.onZoneTick = function(zone)
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

    if (os.time() - zone:getLocalVar('transportTime')) % 60 then
        xi.sea_creatures.checkSpawns(ID, 1, 2) -- 1 percent per vana minute, 2 total mobs
    end

    if os.time() - zone:getLocalVar('transportTime') > 900 then
        zone:setLocalVar('stateSet', 0)
        zone:setLocalVar('state', 1)
    end
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 512) then
        player:setPos(0, 0, 0, 0, 249)
    end
end

return zone_object
