-----------------------------------
-- Spell: Diamondhide
-- Gives party members within area of effect the effect of "Stoneskin"
-- Spell cost: 99 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+1
-- Level: 67
-- Casting Time: 7 seconds
-- Recast Time: 1 minute 30 seconds
-- 5 minutes
-----------------------------------
-- Combos: None
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local blueSkill = utils.clamp(caster:getSkillLevel(xi.skill.BLUE_MAGIC), 0, 500)
    local power = (blueSkill / 3) * 2
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 300)

    if not target:addStatusEffect(xi.effect.STONESKIN, power, 0, duration, 0, 0, 2) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.STONESKIN
end

return spellObject
