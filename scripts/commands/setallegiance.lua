---------------------------------------------------------------------------------------------------
-- func: setallegiance
-- desc: Sets the players allegiance.
---------------------------------------------------------------------------------------------------
cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setallegiance <allegiance> <player>")
end

function onTrigger(player, allegiance, target)
    -- validate target
    local targ
    local cursor_target = player:getCursorTarget()

    if target then
        targ = GetPlayerByName(target)
        if not targ then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    elseif cursor_target and not cursor_target:isNPC() then
        targ = cursor_target
    else
        targ = player
    end

    if allegiance == nil or (allegiance < 0 or allegiance > 6) then
        error(player, "Improper allegiance passed. Valid Values: 0 to 6")
        return
    end

    local toString = {"Mob", "Player", "San d'Oria", "Bastok", "Windurst", "Wyverns", "Griffons"}

    player:PrintToPlayer(string.format("You set %s's allegiance to %s", targ:getName(), toString[allegiance + 1]))
    targ:setAllegiance(allegiance)
end
