-----------------------------------
-- Spell: Animating Wail
-- Increases attack speed
-- Spell cost: 53 MP
-- Monster Type: Undead
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 5
-- Stat Bonus: HP+20
-- Level: 79
-- Casting Time: 2 Seconds
-- Recast Time: 45 Seconds
-- 5 minutes
-----------------------------------
-- Combos: Dual Wield
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local typeEffect = tpz.effect.HASTE
    local power = 1500 -- 15%
    local duration = 300

    if caster:hasStatusEffect(tpz.effect.DIFFUSION) then
        local diffMerit = caster:getMerit(tpz.merit.DIFFUSION)

        if diffMerit > 0 then
            duration = duration + (duration / 100) * diffMerit
        end

        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end

    if not target:addStatusEffect(typeEffect, power, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spell_object
