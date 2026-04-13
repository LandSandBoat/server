-----------------------------------
-- Trust: Curilla
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
        [xi.magic.spell.RAINEMARD] = xi.trust.messageOffset.TEAMWORK_2,
        [xi.magic.spell.RAHAL] = xi.trust.messageOffset.TEAMWORK_3,
        [xi.magic.spell.HALVER] = xi.trust.messageOffset.TEAMWORK_4,
    })

    mob:addListener('ABILITY_USE', 'SENTINEL_USE' .. 'ABILITY', function(mobArg, target, skill, action)
        if skill:getID() == xi.jobAbility.SENTINEL then
            skill:setRecast(skill:getRecast() - 50)
        end
    end)

    mob:addListener('COMBAT_TICK', 'CURILLA_CTICK', function(mobArg)
        local effect = mob:getStatusEffect(xi.effect.SENTINEL)
        if effect and effect:getSubPower() ~= 95 then
            effect:setSubPower(95)
        end
    end)

    mob:addMod(xi.mod.CURE_POTENCY, xi.trust.modGrowthValMax(mob, 25))
    mob:addMod(xi.mod.CURE_CAST_TIME, xi.trust.modGrowthValMax(mob, 50))
    mob:setMod(xi.mod.SENTINEL_EFFECT, xi.trust.modGrowthValMax(mob, 20))
    mob:addMod(xi.mod.ENHANCES_GUARDIAN, xi.trust.modGrowthValMax(mob, 30))
    mob:setMod(xi.mod.SHIELDBLOCKRATE, xi.trust.modGrowthValMax(mob, 25)) -- around 25% max block rate at 99 from testing
    mob:addMod(xi.mod.DMG, -xi.trust.modGrowthValMax(mob, 10))
    mob:addMod(xi.mod.HPP, 10)
    mob:addMod(xi.mod.MPP, 30)
    mob:addMod(xi.mod.ENMITY, 25)

    mob:addGambit(ai.t.SELF,   { ai.c.NOT_STATUS, xi.effect.SENTINEL }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL            })
    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.FLASH    }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH      })
    mob:addGambit(ai.t.PARTY,  { ai.c.HPP_LT,     75                 }, { ai.r.MA, ai.s.HIGHEST,  xi.magic.spellFamily.CURE })

    mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
