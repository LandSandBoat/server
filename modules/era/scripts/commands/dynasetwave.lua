-----------------------------------
-- func: dynasetwave
-- desc: Sets spawns the given wave for given dynamis zone
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "si"
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
    player:PrintToPlayer("!dynasetwave <zoneName> <wave>")
end

function onTrigger(player, zoneName, wave)
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

    wave = tonumber(wave)
    if not wave or wave < 1 or wave > 3 then
        error(player, string.format("[DynaSetWave] Invalid wave provided. Must be 1-3"))
        return
    end

    player:PrintToPlayer(string.format("[DynaSetWave] Despawning current wave for %s...", zone:getName()))
    xi.dynamis.despawnAll(zone)
    xi.dynamis.spawnWave(zone, zone:getID(), wave)
    player:PrintToPlayer(string.format("[DynaSetWave] Finished Spawning Wave %n for %s", wave, zone:getName()))
end