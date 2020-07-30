-----------------------------------
--
--     tpz.effect.HELIX
--
-----------------------------------

require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")

function onEffectGain(target, effect)

end

function onEffectTick(target, effect)
    local dmg = utils.stoneskin(target, effect:getPower())

    if (dmg > 0) then
        target:takeDamage(dmg)
    end

    if (effect:getTick() == 3000) then
        effect:setTick(9000)
    end
end

function onEffectLose(target, effect)

end
