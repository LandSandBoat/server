-----------------------------------
-- Trust: Rainemard
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.CURILLA] = xi.trust.messageOffset.TEAMWORK_1,
    })

    -- TODO: Selection based on enemy weakness
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.ENFIRE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.ENFIRE })

    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.EVASION_DOWN }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.DISTRACT }, 60)

    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.PHALANX }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PHALANX })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.HASTE }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.HASTE })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.REFRESH }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.REFRESH })

    -- If Curilla is present, will cast Haste/Phalanx/Refresh on her.
    mob:addGambit(ai.t.CURILLA, { ai.c.NOT_STATUS, xi.effect.HASTE }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.HASTE })
    mob:addGambit(ai.t.CURILLA, { ai.c.NOT_STATUS, xi.effect.PHALANX }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.PHALANX_II })
    mob:addGambit(ai.t.CURILLA, { ai.c.NOT_STATUS, xi.effect.REFRESH }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.REFRESH })

    -- NOTE: Do these late, to try and avoid clashing with healers casting -ra's
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.PROTECT }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PROTECT })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.SHELL }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.SHELL })
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
