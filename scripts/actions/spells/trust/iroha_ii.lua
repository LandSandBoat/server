-----------------------------------
-- Trust: Iroha II
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.IROHA)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)

    -- TODO: Weaponskills
    --       - Uncomment entries in mob_pool_mods.sql
    --       - Gains 205 TP per hit
    --       - Needs Self Skillchain logic - if Meditate is up and 2000 TP
    --       - 4 Step Double Light Self Skillchain
    --       - Kyori > Hanadoki > Suien > Gachirin
    --       - Needs entries in mob_skill_lists.sql
    --       - Needs skillchain properties in mob_skills.sql
    --       - Needs Weaponskill LUAs
    --       - Holds TP To close Skillchains
    --       - Rise from Ashes:
    --           * Weaponskill that restores 25% HP of All Party, Restores MP, and 500HP Stoneskin
    --           * Will use if 3 or more party are < 25% hp or if a party member is asleep
    -- TODO: Abilities
    -- mob:addSimpleGambit(ai.t.SELF, ai.c.TP_LT, 1000, ai.r.JA, ai.s.SPECIFIC, xi.ja.MEDITATE)
    -- mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.HASSO, ai.r.JA, ai.s.SPECIFIC, xi.ja.HASSO)
    -- mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.THIRD_EYE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLARE_II)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.PROTECT, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.PROTECTRA_V)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.SHELL, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.SHELLRA_V)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
