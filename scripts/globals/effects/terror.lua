-----------------------------------
-- xi.effect.TERROR
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
    -- !unstuck command
    if effect:getPower() == 69 and effect:getTimeRemaining() < 5000 then
        target:delStatusEffect(xi.effect.TERROR)
        local uses = (target:getCharVar("unstuckUses") or 0) + 1
        local cooldownHours = 10 ^ uses -- 10, 100, 1000, etc.
        target:setCharVar("unstuckCooldown", os.time() + (cooldownHours * 3600))
        target:setCharVar("unstuckUses", uses)
        target:warp()
    end
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
