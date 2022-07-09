-----------------------------------
-- Remove OOE NM's from zone.lua
-----------------------------------
require("modules/module_utils")
require("scripts/globals/zone")
require("scripts/globals/treasure")
require("scripts/globals/conquest")
require("scripts/globals/helm")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/chocobo")
require("scripts/globals/beastmentreasure")
require("scripts/missions/amk/helpers")
require("scripts/globals/missions")
require("scripts/globals/missions")
-----------------------------------
local m = Module:new("ooe_nm_zones")

m:addOverride("xi.zones.Beaucedine_Glacier.Zone.onInitialize", function(zone)
    local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
    xi.voidwalker.zoneOnInit(zone)
end)

m:addOverride("xi.zones.Buburimu_Peninsula.Zone.onInitialize", function(zone)
    local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
    xi.helm.initZone(zone, xi.helm.type.LOGGING)
end)

m:addOverride("xi.zones.Castle_Zvahl_Baileys.Zone.onInitialize", function(zone)
    local ID = require("scripts/zones/Castle_Zvahl_Baileys/IDs")
    zone:registerRegion(1, -90, 17, 45, -84, 19, 51)  -- map 4 NW porter
    zone:registerRegion(1, 17, -90, 45, -85, 18, 51)  -- map 4 NW porter
    zone:registerRegion(2, -90, 17, -10, -85, 18, -5)  -- map 4 SW porter
    zone:registerRegion(3, -34, 17, -10, -30, 18, -5)  -- map 4 SE porter
    zone:registerRegion(4, -34, 17, 45, -30, 18, 51)  -- map 4 NE porter

    UpdateNMSpawnPoint(ID.mob.MARQUIS_ALLOCEN)
    GetMobByID(ID.mob.MARQUIS_ALLOCEN):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.MARQUIS_AMON)
    GetMobByID(ID.mob.MARQUIS_AMON):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.DUKE_HABORYM)
    GetMobByID(ID.mob.DUKE_HABORYM):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.GRAND_DUKE_BATYM)
    GetMobByID(ID.mob.GRAND_DUKE_BATYM):setRespawnTime(math.random(900, 10800))

    xi.treasure.initZone(zone)
end)

m:addOverride("xi.zones.East_Sarutabaruta.Zone.onInitialize", function(zone)
end)

m:addOverride("xi.zones.Eastern_Altepa_Desert.Zone.onInitialize", function(zone)
    local ID = require("scripts/zones/Eastern_Altepa_Desert/IDs")
    UpdateNMSpawnPoint(ID.mob.CACTROT_RAPIDO)
    GetMobByID(ID.mob.CACTROT_RAPIDO):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.CENTURIO_XII_I)
    GetMobByID(ID.mob.CENTURIO_XII_I):setRespawnTime(math.random(900, 10800))

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
    xi.chocobo.initZone(zone)
end)

m:addOverride("xi.zones.King_Ranperres_Tomb.Zone.onInitialize", function(zone)
    local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
    zone:registerRegion(1, -84.302, 6.5, -120.997, -77, 7.5, -114) -- Used for stairs teleport -85.1, 7, -119.9

    UpdateNMSpawnPoint(ID.mob.VRTRA)
    GetMobByID(ID.mob.VRTRA):setRespawnTime(math.random(86400, 259200))

    xi.treasure.initZone(zone)
end)

m:addOverride("xi.zones.Tahrongi_Canyon.Zone.onZoneWeatherChange", function(weather)
end)

m:addOverride("xi.zones.Yhoator_Jungle.Zone.onInitialize", function(zone)
    local ID = require("scripts/zones/Yhoator_Jungle/IDs")
    UpdateNMSpawnPoint(ID.mob.WOODLAND_SAGE)
    GetMobByID(ID.mob.WOODLAND_SAGE):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.BISQUE_HEELED_SUNBERRY)
    GetMobByID(ID.mob.BISQUE_HEELED_SUNBERRY):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.BRIGHT_HANDED_KUNBERRY)
    GetMobByID(ID.mob.BRIGHT_HANDED_KUNBERRY):setRespawnTime(math.random(900, 10800))

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())

    xi.helm.initZone(zone, xi.helm.type.HARVESTING)
    xi.helm.initZone(zone, xi.helm.type.LOGGING)
    xi.chocobo.initZone(zone)

    xi.bmt.updatePeddlestox(xi.zone.YUHTUNGA_JUNGLE, ID.npc.PEDDLESTOX)
end)

return m
