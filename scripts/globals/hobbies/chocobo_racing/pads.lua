-----------------------------------
-- Chocobo Racing: Circuit gates and teleport pads
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

local vars =
{
    CIRCUIT_GATE = '[ChocoboCircuit]Gate',
}

-- Each circuit section: the zone its gate leads to and the teleport pad down to the inner circuit.
local circuitGates =
{
    { zone = xi.zone.SOUTHERN_SAN_DORIA,   pad = { -509,   -357   } },
    { zone = xi.zone.BASTOK_MINES,         pad = { -485.4, -532.9 } },
    { zone = xi.zone.WINDURST_WOODS,       pad = { -150,   -548   } },
    { zone = xi.zone.PORT_JEUNO,           pad = { -325.8, -287.7 } },
    { zone = xi.zone.AHT_URHGAN_WHITEGATE, pad = { -163.8, -367.6 } },
}

-- Pads in the inner circuit, which send the player back up to their section.
local innerPads =
{
    { -318.5, -439.8 },
    { -361.1, -457.7 },
    { -361.1, -501.5 },
    { -279.9, -501.4 },
    { -280.2, -457.5 },
}

xi.chocoboRacing.registerPads = function(zone)
    for gate, circuitGate in ipairs(circuitGates) do
        zone:registerCylindricalTriggerArea(gate, circuitGate.pad[1], circuitGate.pad[2], 3)
    end

    for index, pad in ipairs(innerPads) do
        zone:registerCylindricalTriggerArea(#circuitGates + index, pad[1], pad[2], 3)
    end
end

-- Sections only connect through the inner circuit, which always leads back to the section the player came from.
xi.chocoboRacing.onPadsZoneIn = function(player, prevZone)
    for gate, circuitGate in ipairs(circuitGates) do
        if circuitGate.zone == prevZone then
            player:setCharVar(vars.CIRCUIT_GATE, gate)
            break
        end
    end
end

xi.chocoboRacing.onPadsZoneOut = function(player)
    if player:getStatus() ~= xi.status.SHUTDOWN then
        player:setCharVar(vars.CIRCUIT_GATE, 0)
    end
end

xi.chocoboRacing.onPadTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaId = triggerArea:getTriggerAreaID()

    if triggerAreaId <= #circuitGates then
        player:startEvent(247 + triggerAreaId * 2)
    else
        local gate = player:getCharVar(vars.CIRCUIT_GATE)
        if gate == 0 then
            gate = 4 -- Jeuno for GMs / broken charvars
        end

        player:startEvent(248 + gate * 2)
    end
end

-- The city pad events only send an update once the player confirms.
xi.chocoboRacing.onPadEventUpdate = function(player, csid, option)
    if
        csid >= 249 and
        csid <= 257 and
        csid % 2 == 1
    then
        player:setCharVar(vars.CIRCUIT_GATE, (csid - 247) / 2)
    end
end
