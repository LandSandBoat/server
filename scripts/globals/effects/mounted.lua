-----------------------------------
-- xi.effect.MOUNTED
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- Retail sends a music change packet (packet ID 0x5F) in both cases.

    -- TODO: This isn't quite right. The IDs we use for mounts vs what we use for power etc.
    -- seem to be off-by-one.
    if effect:getPower() < 2 then
        target:changeMusic(4, 212)
        target:setAnimation(xi.anim.CHOCOBO)
    else
        target:changeMusic(4, 84)
        target:setAnimation(xi.anim.MOUNT)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setAnimation(xi.anim.NONE)
end

return effectObject
