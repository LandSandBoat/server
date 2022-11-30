-----------------------------------
-- func: givexp <amount> <player>
-- desc: Gives the GM or target player experience points.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!givexp <amount> (player)")
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
    if amount == nil or amount < 1 then
        error(player, "Invalid amount.")
        return
    end

    -- give XP to target
    targ:addExp(amount)
    player:PrintToPlayer(string.format("Gave %i exp to %s. They are now level %i.", amount, targ:getName(), targ:getMainLvl()))
end
