-----------------------------------
-- Trust: Rahal
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
    -- Dragon Killer handled in mob_pool_mods
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.TRION] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.CURILLA] = xi.trust.messageOffset.TEAMWORK_2,
        [xi.magic.spell.EXCENMILLE] = xi.trust.messageOffset.TEAMWORK_3,
        [xi.magic.spell.EXCENMILLE_S] = xi.trust.messageOffset.TEAMWORK_4,
    })

    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.FLASH }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_HAS_TOP_ENMITY, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })
    mob:addGambit(ai.t.SELF, { ai.c.HPP_LT, 33 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL })
    mob:addGambit(ai.t.PARTY, { ai.l.OR(
                                { ai.c.STATUS, xi.effect.SLEEP_I },
                                { ai.c.STATUS, xi.effect.SLEEP_II },
                                { ai.c.STATUS, xi.effect.LULLABY })
                                }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURE })
    mob:addGambit(ai.t.TARGET, { ai.l.OR(
                                { ai.c.CASTING_MA, 0 },
                                { ai.c.READYING_JA, 0 },
                                { ai.c.READYING_MS, 0 },
                                { ai.c.READYING_WS, 0 })
                            }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SHIELD_BASH })
    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 33 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.ENLIGHT }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.ENLIGHT })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.PHALANX }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PHALANX })
    mob:addGambit(ai.t.MASTER, { ai.c.NOT_STATUS, xi.effect.BERSERK }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.BERSERK })

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 2500)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
