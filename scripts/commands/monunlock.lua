-----------------------------------
-- func: monunlock <species or variant> (player)
-- desc: Unlocks one Monstrosity family or variant by its enum name, such as TIGER or FLOWERING_TREANT.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ss'
}

local function printError(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!monunlock <species or variant> (player)')
end

commandObj.onTrigger = function(player, name, target)
    if not name then
        printError(player, 'You must name a species or variant.')
        return
    end

    local targ = player
    if target then
        local named = GetPlayerByName(target)
        if not named then
            printError(player, string.format('Player named "%s" not found!', target))
            return
        end

        targ = named
    end

    local key     = string.upper(name)
    local species = xi.monstrositySpecies[key]
    local variant = xi.monstrosityVariant[key]
    if species then
        xi.monstrosity.unlockSpecies(targ, species)
    elseif variant then
        xi.monstrosity.unlockVariant(targ, variant)
    else
        printError(player, string.format('No species or variant named "%s".', name))
        return
    end

    player:printToPlayer(string.format('%s can now possess %s.', targ:getName(), key))
end

return commandObj
