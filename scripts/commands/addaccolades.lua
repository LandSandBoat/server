-----------------------------------
-- func: addaccolades <amount> <target player>
-- desc: Adds accolades and updates unity leader rank
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "sis"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!addaccolades <amount> {player}")
end

function onTrigger(player, amount, target)
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

    -- validate amount
    if (amount == nil or amount < 1) then
        error(player, "Invalid amount.")
        return
    end

    -- add currency
    targ:addAccolades(amount)
    local newAmount = targ:getCurrency("unity_accolades")
    player:PrintToPlayer(string.format("%s was given %i %s, for a total of %i.", targ:getName(), amount, currency, newAmount))
end
