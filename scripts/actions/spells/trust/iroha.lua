-----------------------------------
-- Trust: Iroha
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.IROHA_II)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)

    -- TODO: Weaponskills
    --       - Uncomment entries in mob_pool_mods.sql
    --       - Needs Self Skillchain logic - if Meditate and Hagakure are available and 2000 TP
    --       - Self Skillchain = Hanadoki > Choun > Fuga > Gachirin > Gachirin
    --       - Needs entries in mob_skill_lists.sql
    --       - Needs skillchain properties in mob_skills.sql
    --       - Needs Weaponskill LUAs
    --       - Holds 2500 TP To close Skillchains
    -- TODO: Abilities
    -- mob:addSimpleGambit(ai.t.SELF, ai.c.TP_LT, 1000, ai.r.JA, ai.s.SPECIFIC, xi.ja.MEDITATE)
    -- mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.HAGAKURE, ai.r.JA, ai.s.SPECIFIC, xi.ja.HAGAKURE)
    -- mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.HASSO, ai.r.JA, ai.s.SPECIFIC, xi.ja.HASSO)
    -- mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.THIRD_EYE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.PROTECT, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.PROTECTRA_V)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.SHELL, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.SHELLRA_V)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)

    -- TODO: Blessing of Phoenix (One Time Reraise with full HP) needs to be Implemented
end

return spellObject
