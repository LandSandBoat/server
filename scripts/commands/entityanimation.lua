---------------------------------------------------------------------------------------------------
-- func: entityanimation
-- desc: Sends an entity animation packet for the given target
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 3,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!entityanimation {npcID} <animationID>")
end

function onTrigger(player, arg1, arg2)
    local targ
    local animationId

    if (arg2 == nil) then
        -- player did not provide npcId.  Shift arguments by one.
        targ = player:getCursorTarget()
        animationId = arg1
    else
        -- player provided npcId and animationId.
        targ = GetNPCByID(tonumber(arg1))
        animationId = arg2
    end

    -- validate target
    if (targ == nil) then
        error(player, "You must either enter a valid npcID or target an entity.")
        return
    end

    targ:entityAnimationPacket(animationId)
end
