---------------------------------------------------------------------------------------------------
-- func: addcurrency <currency type> <amount> <target player>
-- desc: Adds the specified currency to the player
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "sis"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!addcurrency <currency type> <amount> {player}")
end

function onTrigger(player, currency, amount, target)
    -- validate target
    local targ
    if (target == nil) then
        targ = player
    else
        targ = GetPlayerByName(target)
        if (targ == nil) then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- validate currency
    -- note: getCurrency does not ever return nil at the moment.  will work on this in future update.
    if (currency == nil or targ:getCurrency(currency) == nil) then
        error(player, "Invalid currency type.")
        return
    end

    -- validate amount
    if (amount == nil or amount < 1) then
        error(player, "Invalid amount.")
        return
    end

    -- add currency
    targ:addCurrency(currency, amount)
    local newAmount = targ:getCurrency(currency)
    player:PrintToPlayer(string.format("%s was given %i %s, for a total of %i.", targ:getName(), amount, currency, newAmount))
end
