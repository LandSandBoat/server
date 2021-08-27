-----------------------------------
-- xi.effect.MOUNTED
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    --[[
        Retail sends a music change packet (packet ID 0x5F) in both cases.
    ]]

    if effect:getPower() == 0 then
        target:ChangeMusic(4, 212)
        target:setAnimation(xi.anim.CHOCOBO)
    else
        target:ChangeMusic(4, 84)
        target:setAnimation(xi.anim.MOUNT)
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setAnimation(xi.anim.NONE)
end

return effect_object
