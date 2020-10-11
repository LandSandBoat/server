-----------------------------------------
-- Spell: Occultation
-- Creates shadow images that each absorb a single attack directed at you
-- Spell cost: 138 MP
-- Monster Type: Seethers
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+3 CHR-2
-- Level: 88
-- Casting Time: 2 seconds
-- Recast Time: 1 minute, 30 seconds
--
-- Combos: Evasion Bonus
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local typeEffect = tpz.effect.BLINK
    local skill = caster:getSkillLevel(tpz.skill.BLUE_MAGIC)
    local power = (skill / 50)
    local duration = 300

    -- 400 skill = 8 shadows, 450 = 9 shadows, so I am assuming every 50 skill is a shadow.
    -- Also assuming minimum of 2 shadows.
    -- I've never seen the spell cast with under 100 skill, so I could be wrong.
    if (skill < 100) then
        power = 2
    end

    if (caster:hasStatusEffect(tpz.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(tpz.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit
        end

        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end

    if (target:addStatusEffect(typeEffect, power, 0, duration) == false) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end
