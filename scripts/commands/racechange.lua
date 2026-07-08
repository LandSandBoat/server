-----------------------------------
-- func: racechange <player>
-- desc: Make player eligible for Ancestry Moogle Race Change service.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 3,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!racechange (player)')
end

commandObj.onTrigger = function(player, arg1)
    local target

    if arg1 ~= nil then
        target = GetPlayerByName(arg1)
        if target == nil then
            error(player, string.format('Player named "%s" not found!', arg1))
            return
        end
    else
        target = player:getCursorTarget()
        if target and not target:isPC() then
            error(player, 'Target is not a PC')
            return
        end

        if target == nil then
            target = player
        end
    end

    target:setCharVar('[RaceChange]Eligible', GetSystemTime() + 1209600, GetSystemTime() + 1209600)
    target:setCharVar('[RaceChange]Last', 0)

    player:printToPlayer(string.format(
        '%s is now eligible for race change service at Ancestry Moogle. Eligibility will expire in 14 days.',
        target:getName()))
end

return commandObj
