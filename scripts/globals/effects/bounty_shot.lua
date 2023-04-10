-----------------------------------
-- xi.effect.BOUNTY_SHOT
-- https://www.bg-wiki.com/ffxi/Bounty_Shot
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.TREASURE_HUNTER, 2)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.TREASURE_HUNTER, 2)
end

return effectObject
