-----------------------------------
-- xi.effect.FLASH
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    local delAmount = -effect:getPower() / 3 -- Determine how much to remove.
    target:setLocalVar('[FLASH_TICK]DeletedMod', target:getLocalVar('[FLASH_TICK]DeletedMod') + delAmount) -- Keep track of how much we have removed.
    target:delMod(xi.mod.ACC, delAmount) -- Remove more.
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, -effect:getPower() - target:getLocalVar('[FLASH_TICK]DeletedMod')) -- Cleanup any potential lost accuracy after a resist.
end

return effectObject
