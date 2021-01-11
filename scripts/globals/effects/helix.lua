-----------------------------------
-- tpz.effect.HELIX
-----------------------------------
require("scripts/globals/utils")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
end

effect_object.onEffectTick = function(target, effect)
    local dmg = utils.stoneskin(target, effect:getPower())

    if (dmg > 0) then
        target:takeDamage(dmg)
    end

    if (effect:getTick() == 3000) then
        effect:setTick(9000)
    end
end

effect_object.onEffectLose = function(target, effect)
end

return effect_object
