---------------------------------------------------------------------------------------------------
-- func: mp <amount> <player>
-- desc: Sets the GM or target players mana.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!mp <amount> {player}")
end

function onTrigger(player, mp, target)
    -- validate amount
    if (mp == nil or tonumber(mp) == nil) then
        error(player, "You must provide an amount.")
        return
    elseif (mp < 0) then
        error(player, "Invalid amount.")
        return
    end

    -- validate target
    local targ
    local cursor_target = player:getCursorTarget()
    if cursor_target ~= nil then
        targ = cursor_target
    elseif target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if (targ == nil) then
            error(player, string.format( "Player named '%s' not found!", target ) )
            return
        end
    end

    -- set mp
    if (targ:getHP() > 0) then
        targ:setMP(mp)
        if(targ:getID() ~= player:getID()) then
            player:PrintToPlayer(string.format("Set %s's MP to %i.", targ:getName(), targ:getMP()))
        end
    else
        player:PrintToPlayer(string.format("%s is currently dead.", targ:getName()))
    end

end
