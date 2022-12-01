-----------------------------------
-- func: takegil <amount> <player>
-- desc: Removes the amount of gil from the given player.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!takegil <amount> (player)")
end

function onTrigger(player, amount, target)
    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- validate amount
    local oldAmount = targ:getGil()
    if amount == nil or amount < 1 then
        error(player, "Invalid amount of gil.")
        return
    end

    if amount > oldAmount then
        amount = oldAmount
    end

    -- remove gil
    targ:delGil(amount)
    player:PrintToPlayer(string.format("Removed %i gil from %s.  They now have %i gil.", amount, targ:getName(), targ:getGil()))
end
