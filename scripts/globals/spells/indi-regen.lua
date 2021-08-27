-----------------------------------
-- Spell: Indi-Regen
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    if caster:hasStatusEffect(xi.effect.COLURE_ACTIVE) then
        local effect = caster:getStatusEffect(xi.effect.COLURE_ACTIVE)
        if effect:getSubType() == xi.effect.GEO_REGEN then
            return xi.msg.basic.EFFECT_ALREADY_ACTIVE
        end
    end
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local geo_skill = caster:getCharSkillLevel(xi.skill.GEOMANCY)
    local power = (geo_skill / 20) / 10
    if power < 1 then
        power = 1
    end

    caster:addStatusEffectEx(xi.effect.COLURE_ACTIVE, xi.effect.COLURE_ACTIVE, 6, 3, 180, xi.effect.GEO_REGEN, power, xi.auraTarget.ALLIES, xi.effectFlag.AURA)
    return xi.effect.COLURE_ACTIVE
end

return spell_object
