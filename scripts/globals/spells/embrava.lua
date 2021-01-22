-----------------------------------
-- Spell: Embrava
--     Consumes 20% of your maximum MP. Gradually restores
--  target party member's HP and MP and increases attack speed.
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    -- If Tabula Rasa wears before spell goes off, no Embrava for you!
    if not caster:hasStatusEffect(tpz.effect.TABULA_RASA) then
        spell:setMsg(tpz.msg.basic.MAGIC_CANNOT_CAST)
        return 0
    end

    -- Skill caps at 500
    local skill = math.min(caster:getSkillLevel(tpz.skill.ENHANCING_MAGIC), 500)
    local duration = calculateDuration(90, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 5, target:getMainLvl())

    target:addStatusEffect(tpz.effect.EMBRAVA, skill, 0, duration)

    return tpz.effect.EMBRAVA
end

return spell_object
