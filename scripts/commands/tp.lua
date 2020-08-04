---------------------------------------------------------------------------------------------------
-- func: tp <amount> <player>
-- desc: Sets a players tp. If they have a pet, also sets pet tp.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!tp <amount> {player}")
end

function onTrigger(player, tp, target)
    -- validate target
    local targ
    local cursor_target = player:getCursorTarget()

    if target then
        targ = GetPlayerByName(target)
        if not targ then
            error(player, string.format( "Player named '%s' not found!", target ) )
            return
        end
    elseif cursor_target and not cursor_target:isNPC() then
        targ = cursor_target
    else
        targ = player
    end

    -- validate amount
    if tp == nil or tonumber(tp) == nil then
        error(player, "You must provide an amount.")
        return
    elseif tp < 0 then
        error(player, "Invalid amount.")
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
            player:PrintToPlayer(string.format("Set %s's TP to %i.", targ:getName(), targ:getTP()))
        end
    else
        player:PrintToPlayer(string.format("%s is currently dead.", targ:getName()))
    end
end
