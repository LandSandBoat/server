-----------------------------------
-- xi.effect.MARCH
-- getPower returns the TIER (e.g. 1, 2, 3, 4)
-- DO NOT ALTER ANY OF THE EFFECT VALUES! DO NOT ALTER EFFECT POWER!

-- TODO: Find a better way of doing this. Need to account for varying modifiers + CASTER's skill (not target)
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local power = effect:getPower()
    target:addMod(xi.mod.HASTE_MAGIC, power)

    -- Apply Honor March additional modifiers
    -- if power == 3 then
        -- target:addMod(xi.mod.ATT, power)
        -- target:addMod(xi.mod.ACC, power)
        -- target:addMod(xi.mod.RATT, power)
        -- target:addMod(xi.mod.RACC, power)
    -- end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local power = effect:getPower()
    target:delMod(xi.mod.HASTE_MAGIC, power)

    -- Remove Honor March additional modifiers
    -- if power == 3 then
        -- target:delMod(xi.mod.ATT, power)
        -- target:delMod(xi.mod.ACC, power)
        -- target:delMod(xi.mod.RATT, power)
        -- target:delMod(xi.mod.RACC, power)
    -- end
end

return effect_object
