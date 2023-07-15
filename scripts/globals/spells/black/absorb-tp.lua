-----------------------------------
-- Spell: Absorb-TP
-- Steals an enemy's TP.
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
    params.msg = xi.msg.basic.MAGIC_ABSORB_TP
    params.failReturn = xi.effect.NONE
    params.effect = xi.effect.NONE
    params.bonusEffect = xi.effect.NONE
    params.msgFail = xi.msg.basic.MAGIC_FAIL
    params.bonus = 0
    params.baseDuration = 0

    return xi.magic.doAbsorbSpell(caster, target, spell, params)
end

return spellObject
