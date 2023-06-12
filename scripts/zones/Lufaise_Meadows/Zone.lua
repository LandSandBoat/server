-----------------------------------
-- Zone: Lufaise_Meadows (24)
-----------------------------------
local ID = require('scripts/zones/Lufaise_Meadows/IDs')
require('scripts/globals/conquest')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/titles')
require('scripts/globals/helm')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, 179, -26, 327, 219, -18, 347)

    SetServerVariable("realPadfoot", math.random(1, 5))
    for _, v in pairs(ID.mob.PADFOOT) do
        local respawnP = GetServerVariable("\\[SPAWN\\]"..v)
        if os.time() > respawnP then
            SpawnMob(v)
        else
            GetMobByID(v):setRespawnTime(respawnP - os.time())
        end
    end

    if xi.settings.main.ENABLE_WOTG == 1 then
        GetMobByID(ID.mob.YALUN_EKE):setLocalVar("chooseYalun", math.random(1, 2))
    end

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())

    xi.helm.initZone(zone, xi.helm.type.LOGGING)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(458, 6, -4, 82)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

zoneObject.onGameHour = function(zone)
    if xi.settings.main.ENABLE_WOTG == 1 then
        local cooldown = GetMobByID(ID.mob.SENGANN):getLocalVar("cooldown")
        -- Don't allow Sengann to spawn outside of night
        if VanadielHour() >= 4 and VanadielHour() < 20 then
            DisallowRespawn(ID.mob.SENGANN, true)
        elseif os.time() > cooldown then
            DisallowRespawn(ID.mob.SENGANN, false)
        end
    end
end

zoneObject.onZoneWeatherChange = function(weather)
    if xi.settings.main.ENABLE_WOTG == 1 then
        if
            os.time() > GetMobByID(ID.mob.YALUN_EKE):getLocalVar("yalunRespawn") and
            weather == xi.weather.FOG
        then
            local chooseYalun = GetMobByID(ID.mob.YALUN_EKE):getLocalVar("chooseYalun")
            local count = 1

            for k, v in pairs(ID.mob.YALUN_EKE_PH) do
                if count == chooseYalun then
                    DisallowRespawn(k, true)
                    DisallowRespawn(v, false)
                    local pos = GetMobByID(k):getSpawnPos()
                    DespawnMob(k) -- Ensure PH is not up
                    GetMobByID(v):setSpawn(pos.x, pos.y, pos.z)
                    SpawnMob(v) -- Spawn Yal-Un Eke
                else
                    count = count + 1
                end
            end
        end
    end
end

return zoneObject
