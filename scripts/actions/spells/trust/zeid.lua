-----------------------------------
-- Trust: Zeid
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.ZEID_II)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)

    mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.HIGHEST, 1000)

    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.LAST_RESORT }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.LAST_RESORT })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.SOULEATER }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SOULEATER })
    mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.WEAPON_BASH })
    mob:addGambit(ai.t.TARGET, { ai.c.TARGET_CASTING, 0 }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STUN })
    mob:addGambit(ai.t.TARGET, { ai.c.TARGET_READYING, 0 }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STUN })
    mob:addGambit(ai.t.SELF, { ai.c.HPP_LT, 75 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.DRAIN })
    mob:addGambit(ai.t.SELF, { ai.c.MPP_LT, 50 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.ASPIR })
    mob:addGambit(ai.t.TARGET, { ai.c.MPP_GTE, 25 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.ABSORB })
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
