-----------------------------------
-- Spell: Absorb-STR
-- Steals an enemy's strength.
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
    params.msg = xi.msg.basic.MAGIC_ABSORB_STR
    params.failReturn = xi.effect.STR_DOWN
    params.effect = xi.effect.STR_DOWN
    params.bonusEffect = xi.effect.STR_BOOST
    params.msgFail = xi.msg.basic.MAGIC_RESIST
    params.bonus = 0
    params.baseDuration = 46

    return xi.magic.doAbsorbSpell(caster, target, spell, params)
end

return spellObject
