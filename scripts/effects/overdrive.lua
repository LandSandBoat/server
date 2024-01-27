-----------------------------------
-- xi.effect.OVERDRIVE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.OVERLOAD_THRESH, 5000)
    local pet = target:getPet()
    local jpBonus = target:getJobPointLevel(xi.jp.OVERDRIVE_EFFECT) * 5

    if pet then
        pet:setLocalVar('overdrive', 1)
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
        pet:addMod(xi.mod.DMG, -5000)
        if jpBonus > 0 then
            pet:addMod(xi.mod.STR, jpBonus)
            pet:addMod(xi.mod.DEX, jpBonus)
            pet:addMod(xi.mod.VIT, jpBonus)
            pet:addMod(xi.mod.AGI, jpBonus)
            pet:addMod(xi.mod.INT, jpBonus)
            pet:addMod(xi.mod.MND, jpBonus)
            pet:addMod(xi.mod.CHR, jpBonus)
        end
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.OVERLOAD_THRESH, 5000)
    local pet = target:getPet()
    local jpBonus = target:getJobPointLevel(xi.jp.OVERDRIVE_EFFECT) * 5

    if pet and pet:getLocalVar('overdrive') ~= 0 then
        pet:setLocalVar('overdrive', 0)
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
        pet:delMod(xi.mod.DMG, -5000)
        if jpBonus > 0 then
            pet:delMod(xi.mod.STR, jpBonus)
            pet:delMod(xi.mod.DEX, jpBonus)
            pet:delMod(xi.mod.VIT, jpBonus)
            pet:delMod(xi.mod.AGI, jpBonus)
            pet:delMod(xi.mod.INT, jpBonus)
            pet:delMod(xi.mod.MND, jpBonus)
            pet:delMod(xi.mod.CHR, jpBonus)
        end
    end
end

return effectObject
