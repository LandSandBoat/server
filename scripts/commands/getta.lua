-----------------------------------
-- func: getta
-- desc: returns the name of the entity that would be chosen for trick attack given the current (mob) target
-----------------------------------
cmdprops =
{
    permission = 3,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getta with a target")
end

function onTrigger(player)
    local targ = player:getCursorTarget()
    if targ ~= nil then
        local tatarget = player:getTrickAttackChar(targ)
        if tatarget ~= nil then
            player:PrintToPlayer(string.format("Trick attack would select: %s", tatarget:getName()))
        else
            player:PrintToPlayer("No valid TA target found.")
        end
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end
