-----------------------------------
-- func: setgil
-- desc: Sets the players gil.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setgil <amount>")
end

function onTrigger(player, amount)
    -- validate amount
    if amount == nil or amount < 0 then
        error(player, "Invalid amount.")
        return
    end

    player:setGil(amount)
    player:PrintToPlayer(string.format("%s's gil was set to %i.", player:getName(), amount))
end
