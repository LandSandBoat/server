-----------------------------------
-- xi.effect.ASTRAL_FLOW
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:recalculateAbilitiesTable()
    if target:isPC() then
        local jpBonus = target:getJobPointLevel(xi.jp.ASTRAL_FLOW_EFFECT) * 5
        if jpBonus > 0 then
            target:addPetMod(xi.mod.STR, jpBonus)
            target:addPetMod(xi.mod.DEX, jpBonus)
            target:addPetMod(xi.mod.VIT, jpBonus)
            target:addPetMod(xi.mod.AGI, jpBonus)
            target:addPetMod(xi.mod.INT, jpBonus)
            target:addPetMod(xi.mod.MND, jpBonus)
            target:addPetMod(xi.mod.CHR, jpBonus)
        end
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:recalculateAbilitiesTable()
    if target:isPC() then
        local jpBonus = target:getJobPointLevel(xi.jp.ASTRAL_FLOW_EFFECT) * 5
        if jpBonus > 0 then
            target:delPetMod(xi.mod.STR, jpBonus)
            target:delPetMod(xi.mod.DEX, jpBonus)
            target:delPetMod(xi.mod.VIT, jpBonus)
            target:delPetMod(xi.mod.AGI, jpBonus)
            target:delPetMod(xi.mod.INT, jpBonus)
            target:delPetMod(xi.mod.MND, jpBonus)
            target:delPetMod(xi.mod.CHR, jpBonus)
        end
    end
end

return effectObject
