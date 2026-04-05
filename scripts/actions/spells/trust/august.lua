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

    -- Base melee damage boost for tank trusts (1.5x)
    mob:addMod(xi.mod.ATT, math.floor(mob:getMainLvl() * 1.5))

    mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.HIGHEST, 1000)

    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 40 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })
    mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })
    mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS, 0 }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH })
    mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SHIELD_BASH })
    mob:addGambit(ai.t.SELF, { ai.c.HPP_LT, 50 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL })
    mob:addGambit(ai.t.SELF, { ai.c.HPP_LT, 60 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.DEFENDER })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.RAMPART }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.RAMPART })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.PALISADE }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PALISADE })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.WARCRY }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.WARCRY })
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
