-----------------------------------
-- Zone changes for players on player.network.
-----------------------------------
local zoning = {}

-- Zone ticks until the server sends S2C 0x00B and the client acts on it. Returns the client mode.
function zoning.awaitZoneOut(player)
    for _ = 1, 10 do
        xi.test.world:tick()
        player.network:exchange()

        if player.network:mode() ~= 'ingame' then
            break
        end
    end

    return player.network:mode()
end

-- pos is { x, y, z, rot }. Without it the zone's onZoneIn picks the spot.
function zoning.zoneOut(player, destination, pos)
    local target = pos or { 0, 0, 0, 0 }
    player:setPos(target[1], target[2], target[3], target[4], destination)

    return zoning.awaitZoneOut(player)
end

return zoning
