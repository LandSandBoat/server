-----------------------------------
-- Trust: Curilla
-- Possesses MP+30%, Guardian (Sentinel enmity loss -95%), Sentinel Recast merited (-50 sec), Cure Potency Bonus+25%, and Cure Casting Time Down.
-- Does not use Provoke, but will use Flash. This leads to poor hate control.
-- Uses TP randomly and does not try to skillchain.
-- Cures players and trusts in yellow (<75%) HP.
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
            skill:setRecast(skill:getRecast() - 50) -- Sentinel Recast merited (-50 sec)
        end
    end)

    mob:addListener('COMBAT_TICK', 'CURILLA_CTICK', function(mobArg)
        local effect = mob:getStatusEffect(xi.effect.SENTINEL)
        if effect and effect:getSubPower() ~= 95 then
            effect:setSubPower(95) -- Guardian (Sentinel enmity loss -95%)
        end
    end)

    local lvl = mob:getMainLvl()
    local shieldMasteryPower = 0

    if lvl >= 96 then
        shieldMasteryPower = 40
    elseif lvl >= 75 then
        shieldMasteryPower = 30
    elseif lvl >= 50 then
        shieldMasteryPower = 20
    elseif lvl >= 25 then
        shieldMasteryPower = 10
    end

    mob:setMod(xi.mod.SHIELD_MASTERY_TP, shieldMasteryPower)
    mob:addMod(xi.mod.ENHANCES_GUARDIAN, 30)
    mob:setMod(xi.mod.SHIELDBLOCKRATE, 25)
    mob:addMod(xi.mod.CURE_CAST_TIME, 50)
    mob:addMod(xi.mod.CURE_POTENCY, 25)
    mob:addMod(xi.mod.ENMITY, 15)
    mob:addMod(xi.mod.DMG, -500) -- Damage Taken -5%
    mob:addMod(xi.mod.HPP, 10)
    mob:addMod(xi.mod.MPP, 30)

    if lvl >= 30 then
        mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.SENTINEL }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL })
    end

    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.FLASH }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH      })
    mob:addGambit(ai.t.PARTY,  { ai.c.HPP_LT,     75              }, { ai.r.MA, ai.s.HIGHEST,  xi.magic.spellFamily.CURE })

    mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
