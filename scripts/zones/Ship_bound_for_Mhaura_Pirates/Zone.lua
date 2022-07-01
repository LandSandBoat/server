-----------------------------------
--
-- Zone: Ship_bound_for_Mhaura_Pirates (228)
--
-----------------------------------
local ID = require("scripts/zones/Ship_bound_for_Mhaura_Pirates/IDs")
require("scripts/globals/zone")
require("scripts/globals/pirates")
require("scripts/globals/sea_creatures")
-----------------------------------
local zone_object = {}

local function spawnBoatMob(mob)
    mob:spawn()
    mob:setLocalVar("maxVerticalAggro", 4)
end

zone_object.onInitialize = function(zone)
    xi.pirates.init(ID)
end

zone_object.onZoneIn = function(player, prevZone, zone)
    local cs = -1
    local zoneID = 228

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
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

zone_object.onGameHour = function()
    local hour = VanadielHour()
    if hour >= 20 or hour < 4 then
        if math.random() < 0.20 and not GetMobByID(ID.mob.PHANTOM):isSpawned() then
            spawnBoatMob(GetMobByID(ID.mob.PHANTOM))
        end
    elseif GetMobByID(ID.mob.PHANTOM):isSpawned() then
        DespawnMob(ID.mob.PHANTOM)
    end
end

zone_object.onZoneTick = function(zone)
    if zone:getLocalVar('state') == 1 then
        zone:setLocalVar('state', 0)
        if GetMobByID(ID.mob.PHANTOM):isSpawned() then
            DespawnMob(ID.mob.PHANTOM)
        end
        xi.sea_creatures.despawn(ID)
    elseif zone:getLocalVar('state') == 2 then
        zone:setLocalVar('state', 0)
        xi.pirates.start(ID)
        xi.sea_creatures.checkSpawns(ID, 5, 1) -- 5 percent on init
    end

    if (os.time() - zone:getLocalVar('transportTime')) % 60 then
        xi.sea_creatures.checkSpawns(ID, 1, 2) -- 1 percent per vana minute, 2 total mobs
    end

    if os.time() - zone:getLocalVar('transportTime') > 900 then
        zone:setLocalVar('stateSet', 0)
        zone:setLocalVar('state', 1)
    end

    xi.pirates.update(ID, zone, os.time()-zone:getLocalVar('transportTime'))
end

zone_object.onTransportEvent = function(player, transport)
    player:startEvent(512)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 512 then
        player:setPos(0, 0, 0, 0, xi.zone.MHAURA)
    end
end

return zone_object
