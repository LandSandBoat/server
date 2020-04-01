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

    -- validate amount
    if (tp == nil or tonumber(tp) == nil) then
        error(player, "You must provide an amount.")
        return
    elseif (tp < 0) then
        error(player, "Invalid amount.")
        return
    end

    -- validate target
    local targ
    if (target == nil) then
        targ = player
    else
        targ = GetPlayerByName(target)
        if (targ == nil) then
            error(player, string.format( "Player named '%s' not found!", target ) )
            return
        end
    end

    -- set tp
    targ:setTP( tp )
    local pet = targ:getPet()
    if (pet ~= nil) then
        pet:setTP( tp )
    end
    if(targ:getID() ~= player:getID()) then
        player:PrintToPlayer(string.format("Set %s's TP to %i.", targ:getName(), targ:getTP()))
    end
end
