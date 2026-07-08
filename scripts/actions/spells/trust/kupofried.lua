-----------------------------------
-- Trust: Kupofried
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
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)

    mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.NON_COMBAT)

    mob:addMod(xi.mod.AURA_SIZE, 600) -- Trust have a 12 yalm aura 6 base + 6 from mod

    local effectParams =
    {
        power = 6,
        origin = mob,
        tick = 3,
        subType = xi.effect.TRUST_AURA_EXP,
        subPower = 20,
        subIcon = xi.effect.DEDICATION,
        tier = xi.auraTarget.ALLIES,
        flag = xi.effectFlag.AURA
    }

    mob:addStatusEffect(xi.effect.COLURE_ACTIVE, effectParams)

    mob:addGambit(ai.t.SELF, { { ai.c.TIMER, 5 }, { ai.c.RANDOM, 45 } }, { ai.r.ANIM_STRING, ai.s.RANDOM_ANIMATION, 4 })

    mob:setAutoAttackEnabled(false)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
