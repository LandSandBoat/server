---------------------------------------------------------------------------------------------------
-- func: delcurrency <currency type> <amount> <target player>
-- desc: Removes the specified currency from the player
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "sis"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!delcurrency <currency type> <amount> {player}")
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
    local currentAmount = targ:getCurrency(currency)
    if (amount == nil or amount < 1) then
        error(player, "Invalid amount.")
        return
    end
    if (amount > currentAmount) then
        amount = currentAmount
    end

    -- delete currency
    targ:delCurrency(currency, amount)
    local newAmount = targ:getCurrency(currency)
    player:PrintToPlayer(string.format("%i %s was taken from %s, for a total of %i.", amount, currency, targ:getName(), newAmount))
end
