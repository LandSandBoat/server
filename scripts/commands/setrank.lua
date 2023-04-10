-----------------------------------
-- func: setrank
-- desc: Sets the players rank.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setrank <player> <new rank>")
end

function onTrigger(player, target, rank)
    if target == nil then
        error(player, "Set who's rank?")
        return
    end

    local targ = GetPlayerByName(target)

    if targ == nil then
        error(player, string.format("Cannot find player: %s.", target))
        return
    end

    if rank == nil or (rank < 1 or rank > 10) then
        error(player, "Improper rank passed. Valid Values: 1 to 10")
        return
    end

    player:PrintToPlayer(string.format("You set %s's rank to %d", target, rank))
    targ:setRank(rank)
end
