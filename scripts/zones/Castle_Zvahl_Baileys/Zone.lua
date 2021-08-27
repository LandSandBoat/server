-----------------------------------
--
-- Zone: Castle_Zvahl_Baileys (161)
--
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Baileys/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, -90, 17, 45, -84, 19, 51)  -- map 4 NW porter
    zone:registerRegion(1, 17, -90, 45, -85, 18, 51)  -- map 4 NW porter
    zone:registerRegion(2, -90, 17, -10, -85, 18, -5)  -- map 4 SW porter
    zone:registerRegion(3, -34, 17, -10, -30, 18, -5)  -- map 4 SE porter
    zone:registerRegion(4, -34, 17, 45, -30, 18, 51)  -- map 4 NE porter

    UpdateNMSpawnPoint(ID.mob.LIKHO)
    GetMobByID(ID.mob.LIKHO):setRespawnTime(math.random(3600, 4200))

    UpdateNMSpawnPoint(ID.mob.MARQUIS_ALLOCEN)
    GetMobByID(ID.mob.MARQUIS_ALLOCEN):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.MARQUIS_AMON)
    GetMobByID(ID.mob.MARQUIS_AMON):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.DUKE_HABORYM)
    GetMobByID(ID.mob.DUKE_HABORYM):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.GRAND_DUKE_BATYM)
    GetMobByID(ID.mob.GRAND_DUKE_BATYM):setRespawnTime(math.random(900, 10800))

    xi.treasure.initZone(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-181.969, -35.542, 19.995, 254)
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)

    switch (region:GetRegionID()): caseof
    {
        -----------------------------------
        [1] = function (x)  --
        -----------------------------------
            player:startEvent(3) -- ports player to NW room of map 3
        end,

        -----------------------------------
        [2] = function (x)  --
        -----------------------------------
            player:startEvent(2) -- ports player to SW room of map 3
        end,

        -----------------------------------
        [3] = function (x)  --
        -----------------------------------
            player:startEvent(1) -- ports player to SE room of map 3
        end,

        -----------------------------------
        [4] = function (x)  --
        -----------------------------------
            player:startEvent(0) -- ports player to NE room of map 3
        end,

        default = function (x)
        --print("default")
        end,
    }

end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
