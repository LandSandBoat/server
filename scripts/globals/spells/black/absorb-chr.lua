-----------------------------------
-- Spell: Absorb-CHR
-- Steals an enemy's Charism.
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
    params.msg = xi.msg.basic.MAGIC_ABSORB_CHR
    params.failReturn = xi.effect.CHR_DOWN
    params.effect = xi.effect.CHR_DOWN
    params.bonusEffect = xi.effect.CHR_BOOST
    params.msgFail = xi.msg.basic.MAGIC_RESIST
    params.bonus = 0
    params.baseDuration = 46

    return xi.magic.doAbsorbSpell(caster, target, spell, params)
end

return spellObject
