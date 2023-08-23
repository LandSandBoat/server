-----------------------------------
-- func: dynadespawnall
-- desc: Despawns all mobs in given Dynamis instance
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
    player:PrintToPlayer("!dynadespawnall <zoneName>")
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

    xi.dynamis.despawnAll(zone)
    player:PrintToPlayer(string.format("[DynaDespawnAll] Despawned all mobs in zone '%s'", zoneName))
end