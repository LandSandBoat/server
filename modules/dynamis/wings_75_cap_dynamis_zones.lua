--------------------------------------------
--      Dynamis Wings 75 Era Module       --
--------------------------------------------
--------------------------------------------
--       Module Required Scripts          --
--------------------------------------------
require("scripts/globals/dynamis")
require("modules/module_utils")
--------------------------------------------
--       Module Affected Scripts          --
--------------------------------------------
--------------------------------------------

local m = Module:new("wings_75_cap_dynamis_zones")
m:setEnabled(true)

local dynamisZones =
{
    {xi.zone.DYNAMIS_BASTOK, "Dynamis-Bastok"},
    {xi.zone.DYNAMIS_BEAUCEDINE, "Dynamis-Beaucedine"},
    {xi.zone.DYNAMIS_BUBURIMU, "Dynamis-Buburimu"},
    {xi.zone.DYNAMIS_JEUNO, "Dynamis-Jeuno"},
    {xi.zone.DYNAMIS_QUFIM, "Dynamis-Qufim"},
    {xi.zone.DYNAMIS_SAN_DORIA, "Dynamis-San_dOria"},
    {xi.zone.DYNAMIS_TAVNAZIA, "Dynamis-Tavnazia"},
    {xi.zone.DYNAMIS_VALKURM, "Dynamis-Valkurm"},
    {xi.zone.DYNAMIS_WINDURST, "Dynamis-Windurst"},
    {xi.zone.DYNAMIS_XARCABARD, "Dynamis-Xarcabard"}
}

for _, zoneID in pairs(dynamisZones) do
    --super(GetZone(zoneID[1])) -- Returns can't index zone is nil value
    m:addOverride(string.format("xi.zones.%s.Zone.onInitialize", zoneID[2]),
    function(zone)
        xi.dynamis.cleanupDynamis(zone) -- Run cleanupDynamis
    end)
    m:addOverride(string.format("xi.zones.%s.Zone.onZoneTick", zoneID[2]),
    function(zone)
        super(zone)
        xi.dynamis.handleDynamis(zone)
    end)
end

return m