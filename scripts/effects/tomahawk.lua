-----------------------------------
-- xi.effect.TOMAHAWK
-----------------------------------
local effectObject = {}
local physSDT = { xi.mod.SLASH_SDT, xi.mod.PIERCE_SDT, xi.mod.IMPACT_SDT, xi.mod.HTH_SDT }

effectObject.onEffectGain = function(target, effect)
    for i = 1, #physSDT do
        local sdtModPhys = target:getMod(physSDT[i])
        local reductionPhys = (1000 - sdtModPhys) * 0.25

        target:addMod(physSDT[i], reductionPhys)
    end

    for i = 1, #xi.magic.specificDmgTakenMod do
        local sdtModMagic = target:getMod(xi.magic.specificDmgTakenMod[i])
        local reductionMagic = sdtModMagic * 0.25

        target:addMod(xi.magic.specificDmgTakenMod[i], -reductionMagic)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    for i = 1, #physSDT do
        local sdtModPhys = target:getMod(physSDT[i])
        local restorePhys = (1000 - sdtModPhys) / 0.75

        if sdtModPhys <= 250 then
            restorePhys = sdtModPhys
        elseif sdtModPhys >= 1000 then
            restorePhys = 0
        end

        target:delMod(physSDT[i], restorePhys)
    end

    for i = 1, #xi.magic.specificDmgTakenMod do
        local sdtModMagic = target:getMod(xi.magic.specificDmgTakenMod[i])
        local restoreMagic = (sdtModMagic / 0.75) - sdtModMagic

        target:delMod(xi.magic.specificDmgTakenMod[i], -restoreMagic)
    end
end

return effectObject
