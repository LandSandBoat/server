-----------------------------------
-- func: tele
-- desc: teleports char
-----------------------------------
require('scripts/globals/teleports')
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 's'
}

local function isValidCityZone(zoneId)
    local validZones = {
        xi.zone.TAVNAZIAN_SAFEHOLD,
        xi.zone.AHT_URHGAN_WHITEGATE,
        xi.zone.AL_ZAHBI,
        xi.zone.NASHMAU,
        xi.zone.WINDURST_WATERS_S,
        xi.zone.SOUTHERN_SAN_DORIA_S,
        xi.zone.BASTOK_MARKETS_S,
        xi.zone.SOUTHERN_SAN_DORIA,
        xi.zone.NORTHERN_SAN_DORIA,
        xi.zone.PORT_SAN_DORIA,
        xi.zone.CHATEAU_DORAGUILLE,
        xi.zone.BASTOK_MINES,
        xi.zone.BASTOK_MARKETS,
        xi.zone.PORT_BASTOK,
        xi.zone.METALWORKS,
        xi.zone.WINDURST_WATERS,
        xi.zone.WINDURST_WALLS,
        xi.zone.PORT_WINDURST,
        xi.zone.WINDURST_WOODS,
        xi.zone.HEAVENS_TOWER,
        xi.zone.RULUDE_GARDENS,
        xi.zone.UPPER_JEUNO,
        xi.zone.LOWER_JEUNO,
        xi.zone.PORT_JEUNO,
        xi.zone.RABAO,
        xi.zone.SELBINA,
        xi.zone.MHAURA,
        xi.zone.KAZHAM,
        xi.zone.NORG,
    }

    for _, zone in ipairs(validZones) do
        if zoneId == zone then
            return true
        end
    end

    return false
end

commandObj.onTrigger = function(player, tele)
    if player:getAnimation() == xi.animation.SYNTH then
        player:printToPlayer('You cannot do that while crafting. Cheater.')
        return
    end

    if not isValidCityZone(player:getZoneID()) then
        player:printToPlayer('You may only use this command inside a city.')
        return
    end

    local teleports = {
        altep = {
            crystal = xi.ki.ALTEPA_GATE_CRYSTAL,
            id = xi.teleport.id.ALTEP,
            name = 'Altep',
            crystalName = 'Altepa Gate Crystal'
        },
        dem = {
            crystal = xi.ki.DEM_GATE_CRYSTAL,
            id = xi.teleport.id.DEM,
            name = 'Dem',
            crystalName = 'Dem Gate Crystal'
        },
        holla = {
            crystal = xi.ki.HOLLA_GATE_CRYSTAL,
            id = xi.teleport.id.HOLLA,
            name = 'Holla',
            crystalName = 'Holla Gate Crystal'
        },
        mea = {
            crystal = xi.ki.MEA_GATE_CRYSTAL,
            id = xi.teleport.id.MEA,
            name = 'Mea',
            crystalName = 'Mea Gate Crystal'
        },
        vahzl = {
            crystal = xi.ki.VAHZL_GATE_CRYSTAL,
            id = xi.teleport.id.VAHZL,
            name = 'Vahzl',
            crystalName = 'Vahzl Gate Crystal'
        },
        yhoat = {
            crystal = xi.ki.YHOATOR_GATE_CRYSTAL,
            id = xi.teleport.id.YHOAT,
            name = 'Yhoator',
            crystalName = 'Yhoator Gate Crystal'
        },
        jugner = {
            crystal = xi.ki.JUGNER_GATE_CRYSTAL,
            id = xi.teleport.id.JUGNER,
            name = 'Jugner',
            crystalName = 'Jugner Gate Crystal'
        },
        meriph = {
            crystal = xi.ki.MERIPHATAUD_GATE_CRYSTAL,
            id = xi.teleport.id.MERIPH,
            name = 'Meriph',
            crystalName = 'Meriphataud Gate Crystal'
        },
        pashow = {
            crystal = xi.ki.PASHHOW_GATE_CRYSTAL,
            id = xi.teleport.id.PASHH,
            name = 'Pashow',
            crystalName = 'Pashhow Gate Crystal'
        }
    }

    local destination = teleports[tele]

    if destination then
        if player:hasKeyItem(destination.crystal) then
            player:addStatusEffectEx(xi.effect.TELEPORT, 0, destination.id, 0, 5)
            player:printToPlayer(string.format('Teleporting to %s in 5 seconds.', destination.name))
        else
            player:printToPlayer(string.format('%s is required to use this teleport', destination.crystalName))
        end
    else
        player:printToPlayer('Please enter a valid teleport. Command: !tele <location>')
        player:printToPlayer('Acceptable locations: holla, dem, mea, altep, yhoat, vahzl, jugner, meriph, pashow')
        player:printToPlayer('Example: !tele holla')
        player:printToPlayer('Warning: Once you use the command, it cannot be cancelled. Use at own risk.')
    end
end

return commandObj
