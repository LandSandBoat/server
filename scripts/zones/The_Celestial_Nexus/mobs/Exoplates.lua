-----------------------------------
-- Area: The Celestial Nexus
--  Mob: Exoplates
-- Zilart Mission 16 BCNM Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(0)
    mob:setAutoAttackEnabled(false)
    mob:setUnkillable(true)
    mob:setLocalVar('phase', 0)
end

entity.onMobFight = function(mob, target)
    local animationSub = mob:getAnimationSub()
    local mobHPP       = mob:getHPP()
    local phase        = mob:getLocalVar('phase')

    if animationSub == 0 and phase == 0 and mobHPP <= 66 then
        mob:useMobAbility(xi.mobSkill.PHASE_SHIFT_1_EXOPLATES)
    elseif animationSub == 1 and phase == 1 and mobHPP <= 33 then
        mob:useMobAbility(xi.mobSkill.PHASE_SHIFT_2_EXOPLATES)
    elseif animationSub == 2 and phase == 2 and mobHPP <= 2 then
        mob:useMobAbility(xi.mobSkill.PHASE_SHIFT_3_EXOPLATES)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()

    -- First phase end.
    if skillId == xi.mobSkill.PHASE_SHIFT_1_EXOPLATES then
        mob:setLocalVar('phase', 1)
        mob:timer(3000, function(mobArg)
            mobArg:setAnimationSub(1)
        end)

    -- Second phase end.
    elseif skillId == xi.mobSkill.PHASE_SHIFT_2_EXOPLATES then
        mob:setLocalVar('phase', 2)
        mob:timer(3000, function(mobArg)
            mobArg:setAnimationSub(2)
        end)

    -- Third (Last) phase end.
    elseif skillId == xi.mobSkill.PHASE_SHIFT_3_EXOPLATES then
        mob:setLocalVar('phase', 3)
        mob:timer(3000, function(mobArg)
            mobArg:setUnkillable(false)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local ealdnarche = GetMobByID(mob:getID() - 1)

    if ealdnarche then
        ealdnarche:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
        ealdnarche:delStatusEffect(xi.effect.ARROW_SHIELD)
        ealdnarche:delStatusEffect(xi.effect.MAGIC_SHIELD)
    end
end

return entity
