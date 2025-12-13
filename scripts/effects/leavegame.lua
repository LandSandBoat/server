-----------------------------------
-- xi.effect.LEAVEGAME
-----------------------------------
---@type TEffect
local effectObject = {}

local kinds =
{
    LOGOUT   = 1,
    SHUTDOWN = 3,
}

local messages =
{
    [kinds.LOGOUT]   = xi.msg.system.EXECUTING_LOGOUT,
    [kinds.SHUTDOWN] = xi.msg.system.EXECUTING_SHUTDOWN,
}

effectObject.onEffectGain = function(target, effect)
    -- If you're a GM or in a MH, you get disconnected immediately.
    if
        target:inMogHouse() or
        target:getGMLevel() > 0
    then
        target:leaveGame()
        return
    end

    -- addStatusEffect (non-Ex) forces the icon to the effect ID...
    if not target:hasStatusEffect(xi.effect.HEALING) then
        target:addStatusEffectEx(xi.effect.HEALING, 0, 0, xi.settings.map.HEALING_TICK_DELAY, 0, true)
    end

    -- Note: Power stores the kind.
    target:messageSystem(messages[effect:getPower()], 30)
end

effectObject.onEffectTick = function(target, effect)
    -- Note: The type of leavegame may change while it's ticking.
    -- Logout to Shutdown or vice versa.
    -- This has no bearing on the way the player gets disconnected
    -- but it does change the message displayed.
    local elapsedTicks = effect:getTickCount()
    if elapsedTicks > 5 then
        target:leaveGame()
    else
        target:messageSystem(messages[effect:getPower()], 30 - elapsedTicks * 5)
    end
end

effectObject.onEffectLose = function(target, effect)
    target:delStatusEffect(xi.effect.HEALING)
end

return effectObject
