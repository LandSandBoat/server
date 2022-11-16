-----------------------------------
-- func: mobsub
-- desc: Changes the sub-animation of the given mob. (For testing purposes.)
-----------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!mobsub (mob ID) <animation ID>")
end

function onTrigger(player, arg1, arg2)
    local target
    local animationId

    if arg2 ~= nil then
        target = arg1
        animationId = arg2
    elseif arg1 ~= nil then
        animationId = arg1
    else
        error(player, "You must provide an animation ID.")
        return
    end

    -- validate target
    local targ
    if target == nil then
        targ = player:getCursorTarget()
        if targ == nil or not targ:isMob() then
            error(player, "You must either provide a mob ID or target a mob.")
            return
        end
    else
        targ = GetMobByID(target)
        if targ == nil then
            error(player, "Invalid mob ID.")
            return
        end
    end

    -- validate animationId
    animationId = tonumber(animationId) or xi.anim[string.upper(animationId)]
    if animationId == nil or animationId < 0 then
        error(player, "Invalid animation ID.")
        return
    end

    -- set animation sub
    targ:setAnimationSub(animationId)
end
