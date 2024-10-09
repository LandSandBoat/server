-----------------------------------
-- func: gettp <player>
-- desc: Displays target's current TP
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!gettp (player)")
end

function onTrigger(player, tp, target)
    -- validate target
    local targ
    local cursorTarget = player:getCursorTarget()

    if target then
        targ = GetPlayerByName(target)
        if not targ then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    elseif cursorTarget and not cursorTarget:isNPC() then
        targ = cursorTarget
    else
        targ = player
    end

    -- get tp
    if targ:isAlive() then
        targ:getTP(tp)
        local pet = targ:getPet()
        if pet and pet:isAlive() then
            pet:getTP(tp)
        end

        if targ:getID() ~= player:getID() then
            player:PrintToPlayer(string.format("%s's TP is %i.", targ:getName(), targ:getTP()))
        end
    else
        player:PrintToPlayer(string.format("%s is currently dead.", targ:getName()))
    end
end
