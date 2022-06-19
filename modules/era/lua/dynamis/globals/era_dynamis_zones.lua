--------------------------------------------
--         Dynamis 75 Era Module          --
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

local m = Module:new("era_dynamis_zones")

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

local startingZones =
{
    {xi.zone.BASTOK_MINES, "Bastok_Mines", 2},
    {xi.zone.BEAUCEDINE_GLACIER, "Beaucedine_Glacier", 5},
    {xi.zone.BUBURIMU_PENINSULA, "Buburimu_Peninsula", 8},
    {xi.zone.RULUDE_GARDENS, "RuLude_Gardens", 4},
    {xi.zone.QUFIM_ISLAND, "Qufim_Island", 9},
    {xi.zone.SOUTHERN_SAN_DORIA, "Southern_San_dOria", 1},
    {xi.zone.TAVNAZIAN_SAFEHOLD, "Tavnazian_Safehold", 10},
    {xi.zone.VALKURM_DUNES, "Valkurm_Dunes", 7},
    {xi.zone.WINDURST_WALLS, "Windurst_Walls", 3},
    {xi.zone.XARCABARD, "Xarcabard", 6}
}

for _, zoneID in pairs(dynamisZones) do
    m:addOverride(string.format("xi.zones.%s.Zone.onInitialize", zoneID[2]),
    function(zone)
        xi.dynamis.cleanupDynamis(zone) -- Run cleanupDynamis
    end)
    m:addOverride(string.format("xi.zones.%s.Zone.onZoneOut", zoneID[2]),
    function(player)
        xi.dynamis.zoneOnZoneOut(player) -- Run onZoneIn functions.
    end)
    m:addOverride(string.format("xi.zones.%s.Zone.onZoneTick", zoneID[2]),
    function(zone)
        xi.dynamis.handleDynamis(zone)
    end)
end


for _, zoneID in pairs(startingZones) do
    if zoneID[3] >= 7 then
        m:addOverride(string.format("xi.zones.%s.npcs.Hieroglyphics.onTrade", zoneID[2]),
        function(player, npc, trade)
            xi.dynamis.entryNpcOnTrade(player, npc, trade)
        end)
        m:addOverride(string.format("xi.zones.%s.npcs.Hieroglyphics.onEventUpdate", zoneID[2]),
        function(player, npc, trade)
            xi.dynamis.entryNpcOnEventUpdate(player, npc, trade)
        end)
        m:addOverride(string.format("xi.zones.%s.npcs.Hieroglyphics.onEventFinish", zoneID[2]),
        function(player, npc, trade)
            xi.dynamis.entryNpcOnEventFinish(player, npc, trade)
        end)
    else
        m:addOverride(string.format("xi.zones.%s.npcs.Trail_Markings.onTrade", zoneID[2]),
        function(player, npc, trade)
            xi.dynamis.entryNpcOnTrade(player, npc, trade)
        end)
        m:addOverride(string.format("xi.zones.%s.npcs.Trail_Markings.onEventUpdate", zoneID[2]),
        function(player, npc, trade)
            xi.dynamis.entryNpcOnEventUpdate(player, npc, trade)
        end)
        m:addOverride(string.format("xi.zones.%s.npcs.Trail_Markings.onEventFinish", zoneID[2]),
        function(player, npc, trade)
            xi.dynamis.entryNpcOnEventFinish(player, npc, trade)
        end)
    end
end

return m