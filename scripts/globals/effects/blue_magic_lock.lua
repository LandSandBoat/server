-----------------------------------
-- xi.effect.BLUE_MAGIC_LOCK
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    --target:PrintToPlayer("Blue Magic locked for one minute.", xi.msg.channel.SYSTEM_3, "")
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    --target:PrintToPlayer("Blue Magic ready for use.", xi.msg.channel.SYSTEM_3, "")
end

return effectObject
