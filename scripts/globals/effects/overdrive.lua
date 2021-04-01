-----------------------------------
-- xi.effect.OVERDRIVE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.OVERLOAD_THRESH, 5000)
    local pet = target:getPet()
    if pet then
        pet:setLocalVar("overdrive", 1)
        pet:addMod(xi.mod.HASTE_MAGIC, 2500)
        pet:addMod(xi.mod.MAIN_DMG_RATING, 30)
        pet:addMod(xi.mod.RANGED_DMG_RATING, 30)
        pet:addMod(xi.mod.ATTP, 50)
        pet:addMod(xi.mod.RATTP, 50)
        pet:addMod(xi.mod.ACC, 100)
        pet:addMod(xi.mod.RACC, 100)
        pet:addMod(xi.mod.EVA, 50)
        pet:addMod(xi.mod.MEVA, 50)
        pet:addMod(xi.mod.REVA, 50)
        pet:addMod(xi.mod.DMG, -50)
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.OVERLOAD_THRESH, 5000)
    local pet = target:getPet()
    if pet and pet:getLocalVar("overdrive") ~= 0 then
        pet:setLocalVar("overdrive", 0)
        pet:delMod(xi.mod.HASTE_MAGIC, 2500)
        pet:delMod(xi.mod.MAIN_DMG_RATING, 30)
        pet:delMod(xi.mod.RANGED_DMG_RATING, 30)
        pet:delMod(xi.mod.ATTP, 50)
        pet:delMod(xi.mod.RATTP, 50)
        pet:delMod(xi.mod.ACC, 100)
        pet:delMod(xi.mod.RACC, 100)
        pet:delMod(xi.mod.EVA, 50)
        pet:delMod(xi.mod.MEVA, 50)
        pet:delMod(xi.mod.REVA, 50)
        pet:delMod(xi.mod.DMG, -50)
    end
end

return effect_object
