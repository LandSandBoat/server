---------------------------------------------------------------------------------------------------
-- func: setjobpoints <amount> <player>
-- desc: Sets the target players job points count.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setjobpoints <amount> (player)")
end

function onTrigger(player, amount, target)
    -- validate amount
    if amount == nil or amount < 0 then
        error(player, "Invalid amount.")
        return
    elseif amount > 500 then
        amount = 500
    end

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

    local jobNameByNum = {}
    for k, v in pairs(xi.job) do
        jobNameByNum[v] = k
    end

    -- set job points
    targ:setJobPoints(amount)
    player:PrintToPlayer(string.format("%s now has %i job points on %s.", targ:getName(), amount, jobNameByNum[targ:getMainJob()]))
end
