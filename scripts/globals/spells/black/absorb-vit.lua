-----------------------------------
-- Spell: Absorb-VIT
-- Steals an enemy's vitality.
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.DARK_MAGIC
    params.msg = xi.msg.basic.MAGIC_ABSORB_VIT
    params.failReturn = xi.effect.VIT_DOWN
    params.effect = xi.effect.VIT_DOWN
    params.bonusEffect = xi.effect.VIT_BOOST
    params.msgFail = xi.msg.basic.MAGIC_RESIST
    params.bonus = 0
    params.baseDuration = 46

    return xi.magic.doAbsorbSpell(caster, target, spell, params)
end

return spellObject
