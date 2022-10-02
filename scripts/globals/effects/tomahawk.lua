-----------------------------------
-- xi.effect.TOMAHAWK
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local effect_object = {}
local physSDT = { xi.mod.SLASH_SDT, xi.mod.PIERCE_SDT, xi.mod.IMPACT_SDT, xi.mod.HTH_SDT }

effect_object.onEffectGain = function(target, effect)
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

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
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

return effect_object
