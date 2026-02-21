-----------------------------------
-- Trust: Moogle
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
        [xi.magic.spell.FABLINIX] = xi.trust.messageOffset.TEAMWORK_1,
    })

    local mlvl = mob:getMainLvl()
    local tick_amount
    if mlvl == 99 then
        tick_amount = 3
    elseif mlvl < 99 and mlvl > 58 then
        tick_amount = 2
    else
        tick_amount = 1
    end

    mob:addStatusEffect(xi.effect.COLURE_ACTIVE, { power = 6, origin = mob, tick = 3, subType = xi.effect.GEO_REFRESH, subPower = tick_amount, tier = xi.auraTarget.ALLIES, flag = xi.effectFlag.AURA })
    mob:setAutoAttackEnabled(false)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
