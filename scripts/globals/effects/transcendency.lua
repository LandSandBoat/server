-----------------------------------
-- xi.effect.TRANSCENDENCY
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 9000)
    target:addMod(xi.mod.MP, 9000)
    target:addMod(xi.mod.REGEN, 300)
    target:addMod(xi.mod.REFRESH, 300)
    target:addMod(xi.mod.REGAIN, 500)
    target:addMod(xi.mod.STR, 900)
    target:addMod(xi.mod.DEX, 900)
    target:addMod(xi.mod.VIT, 900)
    target:addMod(xi.mod.AGI, 900)
    target:addMod(xi.mod.INT, 900)
    target:addMod(xi.mod.MND, 900)
    target:addMod(xi.mod.CHR, 900)
    target:addMod(xi.mod.ATT, 9000)
    target:addMod(xi.mod.DEF, 9000)
    target:addMod(xi.mod.ACC, 1000)
    target:addMod(xi.mod.EVA, 1000)
    target:addMod(xi.mod.MATT, 900)
    target:addMod(xi.mod.RACC, 1000)
    target:addMod(xi.mod.RATT, 9000)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 9000)
    target:delMod(xi.mod.MP, 9000)
    target:delMod(xi.mod.REGEN, 300)
    target:delMod(xi.mod.REFRESH, 300)
    target:delMod(xi.mod.REGAIN, 500)
    target:delMod(xi.mod.STR, 900)
    target:delMod(xi.mod.DEX, 900)
    target:delMod(xi.mod.VIT, 900)
    target:delMod(xi.mod.AGI, 900)
    target:delMod(xi.mod.INT, 900)
    target:delMod(xi.mod.MND, 900)
    target:delMod(xi.mod.CHR, 900)
    target:delMod(xi.mod.ATT, 9000)
    target:delMod(xi.mod.DEF, 9000)
    target:delMod(xi.mod.ACC, 1000)
    target:delMod(xi.mod.EVA, 1000)
    target:delMod(xi.mod.MATT, 900)
    target:delMod(xi.mod.RACC, 1000)
    target:delMod(xi.mod.RATT, 9000)
end

return effectObject
