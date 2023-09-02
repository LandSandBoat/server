-----------------------------------
-- func: tp <amount> <player>
-- desc: Sets a players tp. If they have a pet, also sets pet tp.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'is'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!tp <amount> (player)')
end

commandObj.onTrigger = function(player, tp, target)
    -- validate target
    local targ
    local cursorTarget = player:getCursorTarget()

    if target then
        targ = GetPlayerByName(target)
        if not targ then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    elseif cursorTarget and not cursorTarget:isNPC() then
        targ = cursorTarget
    else
        targ = player
    end

    -- validate amount
    if tp == nil or tonumber(tp) == nil then
        error(player, 'You must provide an amount.')
        return
    elseif tp < 0 then
        error(player, 'Invalid amount.')
        return
    end

    -- set tp
    if targ:isAlive() then
        targ:setTP(tp)
        local pet = targ:getPet()
        if pet and pet:isAlive() then
            pet:setTP(tp)
        end

        if targ:getID() ~= player:getID() then
            player:PrintToPlayer(string.format('Set %s\'s TP to %i.', targ:getName(), targ:getTP()))
        end
    else
        player:PrintToPlayer(string.format('%s is currently dead.', targ:getName()))
    end
end

return commandObj
