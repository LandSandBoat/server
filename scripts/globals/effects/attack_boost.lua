-----------------------------------
-- xi.effect.ATTACK_BOOST
--
-- getPower()       = ATTP
-- getSubPower()    = RATTP
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if effect:getPower() > 100 then --normalize values(?)
        effect:setPower(50)
    end

    if effect:getSubPower() > 100 then --normalize values(?)
        effect:setSubPower(50)
    end

    target:addMod(xi.mod.ATTP, effect:getPower())
    if effect:getSubPower() > 0 then
        target:addMod(xi.mod.RATTP, effect:getSubPower())
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATTP, effect:getPower())
    if effect:getSubPower() > 0 then
        target:delMod(xi.mod.RATTP, effect:getSubPower())
    end
end

return effectObject
