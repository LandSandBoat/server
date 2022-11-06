-----------------------------------
-- func: cp
-- desc: Adds the given amount cp to the player.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!cp <amount>")
end

function onTrigger(player, cp)
    -- validate amount
    if cp == nil or cp == 0 then
        error(player, "Invalid amount.")
        return
    end

    -- add cp
    player:addCP(cp)
    player:PrintToPlayer(string.format("Added %i cp to %s.", cp, player:getName()))
end
