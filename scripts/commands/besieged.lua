-----------------------------------
-- func: besieged <subcommand> ...
-- desc: Drives Besieged by hand until the system runs itself.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'sssi'
}

local armies =
{
    mamool = xi.besieged.stronghold.MAMOOK,
    troll  = xi.besieged.stronghold.HALVUNG,
    undead = xi.besieged.stronghold.ARRAPAGO,
}

local outcomes =
{
    start = xi.besieged.outcome.START,
    win   = xi.besieged.outcome.WIN,
    loss  = xi.besieged.outcome.LOSS,
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!besieged cs <mamool|troll|undead> <start|win|loss> (leader 0/1)')
    player:printToPlayer('!besieged generals <standing mask 0-31: 1 Rughadjeen, 2 Gadalar, 4 Mihli, 8 Zazarg, 16 Najelith>')
end

commandObj.onTrigger = function(player, subcommand, arg1, arg2, arg3)
    -- Volatile server vars are per map process, so set and read them where the siege plays.
    if player:getZoneID() ~= xi.zone.AL_ZAHBI then
        error(player, 'Besieged commands only work in Al Zahbi.')
        return
    end

    if subcommand == 'generals' then
        local standing = tonumber(arg1)
        if
            not standing or
            standing < 0 or
            standing > 31
        then
            error(player, 'Invalid generals mask.')
            return
        end

        SetVolatileServerVariable('[Besieged]GeneralsCaptured', bit.bxor(standing, 31))
        player:printToPlayer(string.format('Serpent Generals standing: %d', standing))
        return
    end

    if subcommand ~= 'cs' then
        error(player, 'Unknown subcommand.')
        return
    end

    if
        not armies[arg1] or
        not outcomes[arg2]
    then
        error(player, 'Invalid army or outcome.')
        return
    end

    xi.besieged.startSiegeEvent(player,
    {
        stronghold = armies[arg1],
        outcome    = outcomes[arg2],
        leader     = arg3 == 1,
    })
end

return commandObj
