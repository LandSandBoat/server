-----------------------------------
-- func: animation
-- desc: Sets the players current animation.
-----------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!animation (animationID)")
end

function onTrigger(player, animationId)
    local oldAnimation = player:getAnimation()

    if animationId == nil then
        player:PrintToPlayer(string.format("Current player animation: %d", oldAnimation))
        return
    end

    -- validate animationId
    animationId = tonumber(animationId) or xi.anim[string.upper(animationId)]
    if animationId == nil or animationId < 0 then
        error(player, "Invalid animationId.")
        return
    end

    -- set player animation
    player:setAnimation(animationId)
    player:PrintToPlayer(string.format("%s | Old animation: %i | New animation: %i\n", player:getName(), oldAnimation, animationId))
end
