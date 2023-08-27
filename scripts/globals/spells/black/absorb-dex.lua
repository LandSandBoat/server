-----------------------------------
-- Spell: Absorb-DEX
-- Steals an enemy's dexterity.
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
    params.msg = xi.msg.basic.MAGIC_ABSORB_DEX
    params.failReturn = xi.effect.DEX_DOWN
    params.effect = xi.effect.DEX_DOWN
    params.bonusEffect = xi.effect.DEX_BOOST
    params.msgFail = xi.msg.basic.MAGIC_RESIST
    params.bonus = 0
    params.baseDuration = 46

    return xi.magic.doAbsorbSpell(caster, target, spell, params)
end

return spellObject
