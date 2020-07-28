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

function onInitialize(zone)
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

    tpz.treasure.initZone(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-181.969, -35.542, 19.995, 254)
    end
    return cs
end

function onRegionEnter(player, region)

    switch (region:GetRegionID()): caseof
    {
        ---------------------------------
        [1] = function (x)  --
        ---------------------------------
            player:startEvent(3) -- ports player to NW room of map 3
        end,

        ---------------------------------
        [2] = function (x)  --
        ---------------------------------
            player:startEvent(2) -- ports player to SW room of map 3
        end,

        ---------------------------------
        [3] = function (x)  --
        ---------------------------------
            player:startEvent(1) -- ports player to SE room of map 3
        end,

        ---------------------------------
        [4] = function (x)  --
        ---------------------------------
            player:startEvent(0) -- ports player to NE room of map 3
        end,

        default = function (x)
        --print("default")
        end,
    }

end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
