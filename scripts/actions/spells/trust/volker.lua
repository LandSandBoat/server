-----------------------------------
-- Trust: Volker
-- If there is a NIN, PLD, or RUN in the party, behaves as a damage dealer: Uses Aggressor, Berserk.
-- If there are no other tanks in the party, behaves as a tank: Uses Defender, Retaliation.
-- Uses Provoke in either role to maintain enmity as a tank or off-tank.
-- Uses weapon skills at 2000 TP with Warrior's Charge if it's available; does not try to skillchain. (TODO)
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
        [xi.magic.spell.NAJI] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.CID] = xi.trust.messageOffset.TEAMWORK_2,
        [xi.magic.spell.KLARA] = xi.trust.messageOffset.TEAMWORK_3,
    })

    -- DD Mode
    mob:addGambit(ai.t.SELF, { ai.c.PT_HAS_TANK, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.BERSERK })
    mob:addGambit(ai.t.SELF, { ai.c.PT_HAS_TANK, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.AGGRESSOR })
    mob:addGambit(ai.t.TANK, { ai.c.HPP_LT, 50 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })

    -- Tank Mode
    mob:addGambit(ai.t.TARGET, { ai.c.NOT_PT_HAS_TANK, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_PT_HAS_TANK, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.DEFENDER })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_PT_HAS_TANK, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.RETALIATION })

    mob:addGambit(ai.t.MASTER, { ai.c.HPP_LT, 50 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })

    -- TODO: Add Warriors Charge + WS Logic
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
