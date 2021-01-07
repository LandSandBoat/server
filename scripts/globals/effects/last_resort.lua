-----------------------------------
--
--     tpz.effect.LAST_RESORT
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ATTP, 25 + target:getMerit(tpz.merit.LAST_RESORT_EFFECT))
    target:addMod(tpz.mod.HASTE_ABILITY, target:getMod(tpz.mod.DESPERATE_BLOWS) + target:getMerit(tpz.merit.DESPERATE_BLOWS))

    -- Gear that affects this mod is handled by a Latent Effect because the gear must remain equipped
    target:addMod(tpz.mod.DEFP, -25 - target:getMerit(tpz.merit.LAST_RESORT_EFFECT))
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ATTP, 25 + target:getMerit(tpz.merit.LAST_RESORT_EFFECT))
    target:delMod(tpz.mod.HASTE_ABILITY, target:getMod(tpz.mod.DESPERATE_BLOWS) + target:getMerit(tpz.merit.DESPERATE_BLOWS))
     -- Gear that affects this mod is handled by a Latent Effect because the gear must remain equipped
    target:delMod(tpz.mod.DEFP, -25 - target:getMerit(tpz.merit.LAST_RESORT_EFFECT))
end

return effecttbl
