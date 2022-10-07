-----------------------------------
-- Spell: Endark
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- TODO: Get correct animation from retail captures
    local effect     = xi.effect.ENDARK
    local magicskill = target:getSkillLevel(xi.skill.DARK_MAGIC)
    local potency    = 12 + math.floor(magicskill / 20) * 3 - math.floor(magicskill / 40)
    local duration   = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    if target:addStatusEffect(effect, potency, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return effect
end

return spellObject
