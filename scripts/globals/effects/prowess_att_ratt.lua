-----------------------------------
--
-- tpz.effect.PROWESS : Increased treasure casket discovery.
--
-----------------------------------

function onEffectGain(target, effect)
-- This might not be % in retail...If not a % just change ATTP to just ATT
    target:addMod(tpz.mod.ATTP, effect:getPower())
    target:addMod(tpz.mod.RATTP, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ATTP, effect:getPower())
    target:delMod(tpz.mod.RATTP, effect:getPower())
end
