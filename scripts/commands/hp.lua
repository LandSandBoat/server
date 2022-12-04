-----------------------------------
-- func: hp <amount> <player>
-- desc: Sets the GM or target players health.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!hp <amount> (player)")
end

function onTrigger(player, hp, target)
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

    -- validate amount
    if hp == nil or tonumber(hp) == nil then
        error(player, "You must provide an amount.")
        return
    elseif hp < 0 then
        error(player, "Invalid amount.")
        return
    end

    -- set hp
    if targ:isAlive() then
        targ:setHP(hp)
        if targ:getID() ~= player:getID() then
            player:PrintToPlayer(string.format("Set %s's HP to %i.", targ:getName(), targ:getHP()))
        end
    else
        player:PrintToPlayer(string.format("%s is currently dead.", targ:getName()))
    end
end
