-----------------------------------
-- Spell: Metallic Body
-- Absorbs an certain amount of damage from physical and magical attacks
-- Spell cost: 19 MP
-- Monster Type: Aquans
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 1
-- Stat Bonus: None
-- Level: 8
-- Casting Time: 7 seconds
-- Recast Time: 60 seconds
-- Duration: 5 minutes
-----------------------------------
-- Combos: Max MP Boost
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local blueSkill = utils.clamp(caster:getSkillLevel(xi.skill.BLUE_MAGIC), 0, 500)
    local power = utils.clamp(0.375 * blueSkill + 12.5, 0, 150)
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 300)

    if not target:addStatusEffect(xi.effect.STONESKIN, power, 0, duration, 0, 0, 2) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.STONESKIN
end

return spellObject
