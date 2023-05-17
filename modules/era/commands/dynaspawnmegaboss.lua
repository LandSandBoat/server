-----------------------------------
-- func: dynaspawnnm
-- desc: Spawns an NM by index
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

local bosses = {
  ["BASTOK"] = 110,
  ["WINDURST"] = 121,
  ["SAN_DORIA"] = 109,
  ["JEUNO"] = 113,
  ["BEAUCEDINE"] = 163,
  ["XARCABARD"] = 179,
  ["VALKURM"] = 24,
  ["QUFIM"] = 64,
  ["BUBURIMU"] = 61,
  ["TAVNAZIA"] = 0
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!dynaspawnmegaboss <zoneName>")
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

    mobIndex = bosses[zoneName]
    if not mobIndex then
        error(player, string.format("[DynaSpawnMegaBoss] Invalid monster index provided."))
        return
    end

    xi.dynamis.nmDynamicSpawn(mobIndex, nil, true, zone:getID())
    player:PrintToPlayer(string.format("[DynaSpawnMegaBoss] Spawned Notorious Monster %n", mobIndex))
end