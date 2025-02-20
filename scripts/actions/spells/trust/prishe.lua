-----------------------------------
-- Trust: Prishe
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.PRISHE_II)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.ULMIA] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.CHERUKIKI] = xi.trust.messageOffset.TEAMWORK_2,
        [xi.magic.spell.KUKKI_CHEBUKKI] = xi.trust.messageOffset.TEAMWORK_3,
        [xi.magic.spell.MAKKI_CHEBUKKI] = xi.trust.messageOffset.TEAMWORK_4,
        [xi.magic.spell.MILDAURION] = xi.trust.messageOffset.TEAMWORK_5,
    })

    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 25 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
