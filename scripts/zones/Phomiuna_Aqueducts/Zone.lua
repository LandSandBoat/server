-----------------------------------
--
-- Zone: Phomiuna_Aqueducts (27)
--
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    -- Mahisha and Eba share a respawn, random to see who spawns
    if math.random(1,2) == 1 then -- Spawn Eba
        DisallowRespawn(ID.mob.MAHISHA, true)
        GetMobByID(ID.mob.EBA):setRespawnTime(math.random(300, 1200)) -- 5 to 20 minutes
    else -- Spawn Mahisha
        DisallowRespawn(ID.mob.EBA, true)
        GetMobByID(ID.mob.MAHISHA):setRespawnTime(math.random(300, 1200)) -- 5 to 20 minutes
    end

    GetMobByID(ID.mob.TRES_DUENDES):setLocalVar("cooldown", os.time() + math.random(900, 1800))
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(260.02, -2.12, -290.461, 192)
    end

    return cs
end

zone_object.afterZoneIn = function(player)
    if (xi.settings.main.ENABLE_COP_ZONE_CAP == 1) then -- ZONE WIDE LEVEL RESTRICTION
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 40, 0, 0) -- LV40 cap
    end
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
