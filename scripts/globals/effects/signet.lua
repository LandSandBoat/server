-----------------------------------
--
--     tpz.effect.SIGNET
--
--   Signet is a a beneficial Status Effect that allows the acquisition of Conquest Points and Crystals
--   from defeated enemies that grant Experience Points.

--   Increased Healing HP
--   No TP loss while resting
--   Bonus experience earned in smaller parties
--   Increased defense and evasion against attacks from your auto-attack target when even match or lower
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addLatent(tpz.latent.SIGNET_BONUS, 0, tpz.mod.DEF, 15)
    target:addLatent(tpz.latent.SIGNET_BONUS, 0, tpz.mod.EVA, 15)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delLatent(tpz.latent.SIGNET_BONUS, 0, tpz.mod.DEF, 15)
    target:delLatent(tpz.latent.SIGNET_BONUS, 0, tpz.mod.EVA, 15)
end
