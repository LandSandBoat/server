-----------------------------------
--
-- tpz.effect.PROWESS : "Killer" effects bonus
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.VERMIN_KILLER, effect:getPower())
    target:addMod(tpz.mod.BIRD_KILLER, effect:getPower())
    target:addMod(tpz.mod.AMORPH_KILLER, effect:getPower())
    target:addMod(tpz.mod.LIZARD_KILLER, effect:getPower())
    target:addMod(tpz.mod.AQUAN_KILLER, effect:getPower())
    target:addMod(tpz.mod.PLANTOID_KILLER, effect:getPower())
    target:addMod(tpz.mod.BEAST_KILLER, effect:getPower())
    target:addMod(tpz.mod.UNDEAD_KILLER, effect:getPower())
    target:addMod(tpz.mod.ARCANA_KILLER, effect:getPower())
    target:addMod(tpz.mod.DRAGON_KILLER, effect:getPower())
    target:addMod(tpz.mod.DEMON_KILLER, effect:getPower())
    target:addMod(tpz.mod.EMPTY_KILLER, effect:getPower())
    -- target:addMod(tpz.mod.HUMANOID_KILLER, effect:getPower())
    target:addMod(tpz.mod.LUMORIAN_KILLER, effect:getPower())
    target:addMod(tpz.mod.LUMINION_KILLER, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.VERMIN_KILLER, effect:getPower())
    target:delMod(tpz.mod.BIRD_KILLER, effect:getPower())
    target:delMod(tpz.mod.AMORPH_KILLER, effect:getPower())
    target:delMod(tpz.mod.LIZARD_KILLER, effect:getPower())
    target:delMod(tpz.mod.AQUAN_KILLER, effect:getPower())
    target:delMod(tpz.mod.PLANTOID_KILLER, effect:getPower())
    target:delMod(tpz.mod.BEAST_KILLER, effect:getPower())
    target:delMod(tpz.mod.UNDEAD_KILLER, effect:getPower())
    target:delMod(tpz.mod.ARCANA_KILLER, effect:getPower())
    target:delMod(tpz.mod.DRAGON_KILLER, effect:getPower())
    target:delMod(tpz.mod.DEMON_KILLER, effect:getPower())
    target:delMod(tpz.mod.EMPTY_KILLER, effect:getPower())
    -- target:delMod(tpz.mod.HUMANOID_KILLER, effect:getPower())
    target:delMod(tpz.mod.LUMORIAN_KILLER, effect:getPower())
    target:delMod(tpz.mod.LUMINION_KILLER, effect:getPower())
end
