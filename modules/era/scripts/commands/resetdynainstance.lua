-----------------------------------
-- func: resetdyna
-- desc: Resets an instance of Dynamis
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

local zoneMap =
{
    ["BASTOK"] = xi.zone.DYNAMIS_BASTOK,
    ["WINDURST"] = xi.zone.DYNAMIS_WINDURST,
    ["SAN_DORIA"] = xi.zone.DYNAMIS_SAN_DORIA,
    ["JEUNO"] = xi.zone.DYNAMIS_JEUNO,
    ["BEAUCEDINE"] = xi.zone.DYNAMIS_BEAUCEDINE,
    ["XARCABARD"] = xi.zone.DYNAMIS_XARCABARD,
    ["VALKURM"] = xi.zone.DYNAMIS_VALKURM,
    ["QUFIM"] = xi.zone.DYNAMIS_QUFIM,
    ["BUBURIMU"] = xi.zone.DYNAMIS_BUBURIMU,
    ["TAVNAZIA"] = xi.zone.DYNAMIS_TAVNAZIA
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!resetdyna <zoneName>")
end

function onTrigger(player, zoneName)
    if not zoneName or zoneName == "" then
        error(player, "Invalid zone name provided.")
    end

    zoneName = string.upper(zoneName)
    local zoneKey = zoneMap[zoneName]
    if not zoneKey then
        error(player, "Invalid zone name provided.")
        player:PrintToPlayer("Valid options: bastok, windurst, san_doria, jeuno, beaucedine, xarcabard, valkurm, qufim, buburimu, tavnazia")
        return
    end

    local zone = GetZone(zoneMap[zoneName])
    if not zone then
        error(player, "Failed to get dynamis zone.")
        return
    end

    -- Get Instance ID for zone
    local instanceID = GetServerVariable(string.format("[DYNA]InstanceID_%s", zone:getID()))

    -- Eject inhabiting players
    if #zone:getPlayers() > 0 then
        xi.dynamis.ejectAllPlayers(zone)
    end

    -- Cleanup the zone
    xi.dynamis.cleanupDynamis(zone)

    -- Reset all player's dynamis variables
    -- luacheck: ignore 113
    ResetDynamisInstance(instanceID)
    player:PrintToPlayer(string.format("ResetDyna: Successfully reset Dynamis Instance %s for Zone: %s", instanceID, zoneName))
end
