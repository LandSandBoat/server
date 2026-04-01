-----------------------------------
-- Trust: August
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
        [xi.magic.spell.ARCIELA]   = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.TEODOR]    = xi.trust.messageOffset.TEAMWORK_2,
        [xi.magic.spell.ROSULATIA] = xi.trust.messageOffset.TEAMWORK_3,
        [xi.magic.spell.MORIMAR]   = xi.trust.messageOffset.TEAMWORK_4,
    })

    mob:setMobSkillAttack(1197)

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 2500)

    -- Priority 1: Provoke when not top enmity (JA, no MP)
    mob:addGambit(ai.t.SELF, { ai.c.NOT_HAS_TOP_ENMITY, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })

    -- Priority 2: Shield Bash on recast (JA, no MP, stun + enmity)
    mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SHIELD_BASH })

    -- Priority 3-6: Defensive JAs (no MP cost, use when available)
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.SENTINEL }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.DEFENDER }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.DEFENDER })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.RAMPART }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.RAMPART })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.PALISADE }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PALISADE })

    -- Priority 7: Warcry for party ATT boost (WAR sub, no MP)
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.WARCRY }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.WARCRY })

    -- Priority 6: Flash on recast (costs MP but high enmity, only fires when JAs exhausted)
    mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS, 0 }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH })

    -- Priority 7: Cure party at 75% HP (costs MP, enmity from healing)
    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 75 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
