----------------------------------------
-- tpz.effect.OVERDRIVE
----------------------------------------
require("scripts/globals/status")
----------------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.OVERLOAD_THRESH, 5000)
    local pet = target:getPet()
    if pet then
        pet:setLocalVar("overdrive", 1)
        pet:addMod(tpz.mod.HASTE_MAGIC, 2500)
        pet:addMod(tpz.mod.MAIN_DMG_RATING, 30)
        pet:addMod(tpz.mod.RANGED_DMG_RATING, 30)
        pet:addMod(tpz.mod.ATTP, 50)
        pet:addMod(tpz.mod.RATTP, 50)
        pet:addMod(tpz.mod.ACC, 100)
        pet:addMod(tpz.mod.RACC, 100)
        pet:addMod(tpz.mod.EVA, 50)
        pet:addMod(tpz.mod.MEVA, 50)
        pet:addMod(tpz.mod.REVA, 50)
        pet:addMod(tpz.mod.DMG, -50)
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.OVERLOAD_THRESH, 5000)
    local pet = target:getPet()
    if pet and pet:getLocalVar("overdrive") ~= 0 then
        pet:setLocalVar("overdrive", 0)
        pet:delMod(tpz.mod.HASTE_MAGIC, 2500)
        pet:delMod(tpz.mod.MAIN_DMG_RATING, 30)
        pet:delMod(tpz.mod.RANGED_DMG_RATING, 30)
        pet:delMod(tpz.mod.ATTP, 50)
        pet:delMod(tpz.mod.RATTP, 50)
        pet:delMod(tpz.mod.ACC, 100)
        pet:delMod(tpz.mod.RACC, 100)
        pet:delMod(tpz.mod.EVA, 50)
        pet:delMod(tpz.mod.MEVA, 50)
        pet:delMod(tpz.mod.REVA, 50)
        pet:delMod(tpz.mod.DMG, -50)
    end
end

return effecttbl
