---------------------------------------------------------------------------------------------------
-- func: setallegiance
-- desc: Sets the players allegiance.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setallegiance <player> <allegiance>")
end

function onTrigger(player, target, allegiance)

    -- validate target
    local targ
    if (target == nil) then
        targ = player
    else
        targ = GetPlayerByName(target)
        if (targ == nil) then
            error(player, string.format( "Player named '%s' not found!", target ) )
            return
        end
    end

    if allegiance == nil or (allegiance < 0 or allegiance > 6) then
        error(player, "Improper allegiance passed. Valid Values: 0 to 6")
        return
    end

    local toString = {
        "Mob", "Player",
        "San d'Oria", "Bastok", "Windurst",
        "Wyverns", "Griffons"
    }

    player:PrintToPlayer(string.format("You set %s's allegiance to %s", target, toString[allegiance + 1]))
    targ:setAllegiance(allegiance)
end