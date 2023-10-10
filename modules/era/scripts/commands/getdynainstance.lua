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
    player:PrintToPlayer("!getdynainstance <zoneName>")
end

function onTrigger(player, zoneName)
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

    if not instanceID or instanceID == 0 then
        player:PrintToPlayer(string.format("GetDynaInstance: Zone (%s) No Active Instances", zoneName))
    else
        player:PrintToPlayer(string.format("GetDynaInstance: Zone (%s) InstanceID (%s)", zoneName, instanceID))
    end
end
