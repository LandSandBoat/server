-----------------------------------
-- Area: Navukgo Execution Chamber
--   NM: Two-faced Flan
-----------------------------------
---@type TMobEntity
local entity = {}

local function smooth(mob)
    mob:setAnimationSub(1)
    mob:setMagicCastingEnabled(true)
    mob:setMod(xi.mod.DMGMAGIC, -3333)
    mob:setMod(xi.mod.DMGPHYS, 0)
    mob:setMod(xi.mod.DELAYP, 0)
    mob:setMod(xi.mod.REGAIN, 0)
    mob:setLocalVar('spikesTime', GetSystemTime() + math.random(20, 60))
end

local function spikes(mob)
    mob:setAnimationSub(2)
    mob:setMagicCastingEnabled(false)
    mob:setMod(xi.mod.DMGMAGIC, 0)
    mob:setMod(xi.mod.DMGPHYS, -5000)
    mob:setMod(xi.mod.DELAYP, -50)
    mob:setMod(xi.mod.REGAIN, 200)
    mob:setLocalVar('smoothTime', GetSystemTime() + math.random(20, 60))
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)

    mob:addListener('TAKE_DAMAGE', 'TAKE_DAMAGE_FLAN', function(mobArg, damage, attacker, attackType, damageType)
        if
            mob:getAnimationSub() == 1 and
            (attackType == xi.attackType.PHYSICAL or attackType == xi.attackType.RANGED) and
            GetSystemTime() >= mobArg:getLocalVar('spikesTime')
        then
            spikes(mobArg)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
    mob:setMod(xi.mod.REFRESH, 100)
    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, 50)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 9)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 2)
    mob:setMobMod(xi.mobMod.STANDBACK_COOL, 0)
    smooth(mob)
end

entity.onMobFight = function(mob, target)
    if mob:getAnimationSub() == 1 then
        return
    end

    if GetSystemTime() >= mob:getLocalVar('smoothTime') then
        smooth(mob)
        mob:useMobAbility(xi.mobSkill.XENOGLOSSIA)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.AMORPHIC_SCYTHE,
        xi.mobSkill.AMORPHIC_SPIKES,
        xi.mobSkill.BOILING_POINT
    }

    return skillList[math.random(1, #skillList)]
end

return entity
