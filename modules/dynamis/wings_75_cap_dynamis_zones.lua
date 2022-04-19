--------------------------------------------
--    Dynamis Zones Wings 75 Era Module   --
--------------------------------------------
--------------------------------------------
--       Module Required Scripts          --
--------------------------------------------
require("scripts/globals/dynamis")
require("modules/module_utils")
--------------------------------------------
--       Module Affected Scripts          --
--------------------------------------------
require("scripts/zones/Dynamis-Bastok/zone")
require("scripts/zones/Dynamis-Beaucedine/zone")
require("scripts/zones/Dynamis-Buburimu/zone")
require("scripts/zones/Dynamis-Jeuno/zone")
require("scripts/zones/Dynamis-Qufim/zone")
require("scripts/zones/Dynamis-San_dOria/zone")
require("scripts/zones/Dynamis-Tavnazia/zone")
require("scripts/zones/Dynamis-Valkurm/zone")
require("scripts/zones/Dynamis-Windurst/zone")
require("scripts/zones/Dynamis-Xarcabard/zone")
--------------------------------------------

local m = Module:new("wings_75_cap_dynamis_zones")
m:setEnabled(true)

--------------------------------------------
--       Module Function Overrides        --
--------------------------------------------

m:addOverride(string.format("xi.zones.%s.onInitialize", zone:getName()), function(zone)
    xi.dynamis.cleanupDynamis(zone)
end)

--------------------------------------------
--         Module New Functions           --
--------------------------------------------

local dynamisZoneIDs = -- List off all dynamis zone IDs for loop.
{
    xi.zone.DYNAMIS_BASTOK,
    xi.zone.DYNAMIS_BEAUCEDINE,
    xi.zone.DYNAMIS_BUBURIMU,
    xi.zone.DYNAMIS_JEUNO,
    xi.zone.DYNAMIS_QUFIM,
    xi.zone.DYNAMIS_SAN_DORIA,
    xi.zone.DYNAMIS_TAVNAZIA,
    xi.zone.DYNAMIS_VALKURM,
    xi.zone.DYNAMIS_WINDURST,
    xi.zone.DYNAMIS_XARCABARD,
}

for _, zoneID in pairs(dynamisZoneIDs ) do
    local zone = GetZone(zoneID) -- Get zone of the zoneID
    -- To add additional dynamis functions to new zone functions copy the below, change onZoneTick to whatever new function, and change the proposed function.
    xi["zones"][zone:getName()]["Zone"]["onZoneTick"] = xi.dynamis.handleDynamis(zone) -- Run handleDynamis
end

return m