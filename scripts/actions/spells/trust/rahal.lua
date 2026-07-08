-----------------------------------
-- Trust: Rahal
-- Possesses Dragon Killer.
-- Rahal is an aggressive tank who uses Berserk.
-- Prioritizes Flash over Provoke.
-- Will only cast Cure when a party member is below 33% health and will use the highest tier available.
-- Will only use Sentinel when he is below 35% health.
-- He tries to interrupt TP-abilities and high-tier spells with Shield Bash.
-- Holds up to 2500 TP to close skillchains.
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
        [xi.magic.spell.TRION] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.CURILLA] = xi.trust.messageOffset.TEAMWORK_2,
        [xi.magic.spell.EXCENMILLE] = xi.trust.messageOffset.TEAMWORK_3,
        [xi.magic.spell.EXCENMILLE_S] = xi.trust.messageOffset.TEAMWORK_4,
    })

    -- Dragon Killer handled in mob_pool_mods
    mob:addMod(xi.mod.ENMITY, 10)
    mob:addMod(xi.mod.DMG, -500) -- Damage Taken -5%
    mob:addMod(xi.mod.HPP, 10)

    local lvl = mob:getMainLvl()

    if lvl >= 10 then
        mob:addGambit(ai.t.SELF, { ai.c.NOT_HAS_TOP_ENMITY, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })
    end

    if lvl >= 15 then
        mob:addGambit(ai.t.TARGET, { ai.l.OR(
            { ai.c.CASTING_MA, 0 },
            { ai.c.READYING_JA, 0 },
            { ai.c.READYING_MS, 0 },
            { ai.c.READYING_WS, 0 }) }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SHIELD_BASH })
    end

    if lvl >= 30 then
        mob:addGambit(ai.t.MASTER, { ai.c.NOT_STATUS, xi.effect.BERSERK }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.BERSERK  })
        mob:addGambit(ai.t.SELF,   { ai.c.HPP_LT,     35                }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL })
    end

    mob:addGambit(ai.t.PARTY,  { ai.c.HPP_LT,     33                }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE    })
    mob:addGambit(ai.t.SELF,   { ai.c.NOT_STATUS, xi.effect.ENLIGHT }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.ENLIGHT })
    mob:addGambit(ai.t.SELF,   { ai.c.NOT_STATUS, xi.effect.PHALANX }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PHALANX })
    mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS,     xi.effect.FLASH   }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH        })
    mob:addGambit(ai.t.PARTY,  { ai.c.STATUS,     xi.effect.SLEEP_I }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURE         })

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 2500)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
