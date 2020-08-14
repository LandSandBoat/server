-----------------------------------
--
--    Companions Roll
--
-----------------------------------

require("scripts/globals/status")

function onEffectGain(target, effect)
    local effectregain = {20, 50, 20, 20, 30, 30, 30, 40, 40, 10, 60, 0}
    local effectregen = {4, 20, 6, 8, 10, 12, 14, 16, 18, 3, 25, 0}
    if (effect:getPower() > 69) then
        local rollnum = (effect:getPower() - 70)
        target:addPetMod(tpz.mod.REGAIN, (effectregain[rollnum] + 35))
        target:addPetMod(tpz.mod.REGEN, (effectregen[rollnum] +14))
    end
    if (effect:getPower() > 49 and effect:getPower() <69) then
        local rollnum = (effect:getPower() - 50)
        target:addPetMod(tpz.mod.REGAIN, (effectregain[rollnum] +25))
        target:addPetMod(tpz.mod.REGEN, (effectregen[rollnum] +10))
    end
    if (effect:getPower() > 29 and effect:getPower() <49) then
        local rollnum = (effect:getPower() - 30)
        target:addPetMod(tpz.mod.REGAIN, (effectregain[rollnum] +15))
        target:addPetMod(tpz.mod.REGEN, (effectregen[rollnum] +6))
    end
    if (effect:getPower() < 19 ) then
        local rollnum = effect:getPower()
        target:addPetMod(tpz.mod.REGAIN, effectregain[rollnum])
        target:addPetMod(tpz.mod.REGEN, effectregen[rollnum])
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local effectregain = {20, 50, 20, 20, 30, 30, 30, 40, 40, 10, 60, 0}
    local effectregen = {4, 20, 6, 8, 10, 12, 14, 16, 18, 3, 25, 0}
    if (effect:getPower() > 69) then
        local rollnum = (effect:getPower() - 70)
        target:delPetMod(tpz.mod.REGAIN, (effectregain[rollnum] + 35))
        target:delPetMod(tpz.mod.REGEN, (effectregen[rollnum] +14))
    end
    if (effect:getPower() > 49 and effect:getPower() <69) then
        local rollnum = (effect:getPower() - 50)
        target:delPetMod(tpz.mod.REGAIN, (effectregain[rollnum] +25))
        target:delPetMod(tpz.mod.REGEN, (effectregen[rollnum] +10))
    end
    if (effect:getPower() > 29 and effect:getPower() <49) then
        local rollnum = (effect:getPower() - 30)
        target:delPetMod(tpz.mod.REGAIN, (effectregain[rollnum] +15))
        target:delPetMod(tpz.mod.REGEN, (effectregen[rollnum] +6))
    end
    if (effect:getPower() < 19) then
        local rollnum = effect:getPower()
        target:delPetMod(tpz.mod.REGAIN, effectregain[rollnum])
        target:delPetMod(tpz.mod.REGEN, effectregen[rollnum])
    end
end
