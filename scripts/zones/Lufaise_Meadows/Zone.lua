-----------------------------------
-- Zone: Lufaise_Meadows (24)
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
require("scripts/globals/conquest")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
require("scripts/globals/helm")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, 179, -26, 327, 219, -18, 347)

    SetServerVariable("realPadfoot", math.random(1, 5))
    for _, v in pairs(ID.mob.PADFOOT) do
        SpawnMob(v)
    end

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())

    xi.helm.initZone(zone, xi.helm.type.LOGGING)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-475.825, -20.461, 281.149, 11)
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

zone_object.onGameHour = function(zone)
    -- Don't allow Manes or Shii to spawn outside of night
    if VanadielHour() >= 4 and VanadielHour() < 20 then
        DisallowRespawn(ID.mob.SENGANN, true)
    else
        DisallowRespawn(ID.mob.SENGANN, false)
        GetMobByID(ID.mob.SENGAN):setRespawnTime(math.random(30, 150)) -- pop 30-150 sec after night starts
    end
end

zone_object.onZoneWeatherChange = function(weather)
    if os.time() > GetMobByID(ID.mob.YALUN_EKE):getLocalVar("yalunRespawn") and weather == xi.weather.FOG then
        local chooseYalun = GetMobByID(ID.mob.YALUN_EKE):setLocalVar("chooseYalun")
        local count = 1

        for ph, nm in pairs(ID.mob.ODQAN_PH) do
            if count == chooseYalun then
                DisallowRespawn(ph, true)
                DisallowRespawn(nm, false)
                local pos = GetMobByID(ph):getSpawnPos()
                DespawnMob(ph) -- Ensure PH is not up
                GetMobByID(nm):setSpawn(pos[1], pos[2], pos[3])
                SpawnMob(nm) -- Spawn Yal-Un Eke
            else
                count = count + 1
            end
        end
    end
end

return zone_object
