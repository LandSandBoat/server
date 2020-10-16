-----------------------------------------
-- Spell: Indi-Poison
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    if caster:hasStatusEffect(tpz.effect.COLURE_ACTIVE) then
    	local effect = caster:getStatusEffect(tpz.effect.COLURE_ACTIVE)
		if effect:getSubType() ==  tpz.effect.GEO_POISON then
		    return tpz.msg.basic.EFFECT_ALREADY_ACTIVE
		end
	end
    return 0
end

function onSpellCast(caster, target, spell)
    local geo_skill = caster:getCharSkillLevel(tpz.skill.GEOMANCY)
    local power = (geo_skill / 30) / 10
    if power < 1 then
        power = 1
    end

    caster:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 13, 3, 180, tpz.effect.GEO_POISON, power, tpz.auraTarget.ENEMIES, tpz.effectFlag.AURA)
    return tpz.effect.COLURE_ACTIVE
end
