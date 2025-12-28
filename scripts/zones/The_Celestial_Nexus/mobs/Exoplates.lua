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
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 100)                -- When left alone, still uses TP moves.
    mob:setMod(xi.mod.DESPAWN_TIME_REDUCTION, 15) -- Fast despawn.
    mob:setMod(xi.mod.MDEF, 50)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 40)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 2057)     -- Default skill list.
    mob:setAnimationSub(0)
    mob:setAutoAttackEnabled(false)
    mob:setUnkillable(true) -- Death is scripted.
end

entity.onMobFight = function(mob, target)
    -- Early return: Entity can't act.
    if
        xi.combat.behavior.isEntityBusy(mob) or
        mob:getTP() < 600
    then
        return
    end

    -- Phase change logic.
    local animationSub = mob:getAnimationSub()
    local mobHPP       = mob:getHPP()

    if animationSub == 0 and mobHPP <= 66 then
        mob:useMobAbility(xi.mobSkill.PHASE_SHIFT_1_EXOPLATES)
    elseif animationSub == 1 and mobHPP <= 33 then
        mob:useMobAbility(xi.mobSkill.PHASE_SHIFT_2_EXOPLATES)
    elseif animationSub == 2 and mobHPP <= 1 then
        mob:useMobAbility(xi.mobSkill.PHASE_SHIFT_3_EXOPLATES)
    end
end

-- Note: This mobskills aren't in any skill list, and shouldn't be. Their use is 100% scripted.
entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()

    -- First phase end.
    if skillId == xi.mobSkill.PHASE_SHIFT_1_EXOPLATES then
        mob:setMobMod(xi.mobMod.SKILL_LIST, 2058)
        mob:timer(2000, function(mobArg)
            mobArg:setAnimationSub(1)
        end)

    -- Second phase end.
    elseif skillId == xi.mobSkill.PHASE_SHIFT_2_EXOPLATES then
        mob:setMobMod(xi.mobMod.SKILL_LIST, 2059)
        mob:timer(2000, function(mobArg)
            mobArg:setAnimationSub(2)
        end)

    -- Third (Last) phase end.
    elseif skillId == xi.mobSkill.PHASE_SHIFT_3_EXOPLATES then
        mob:timer(2000, function(mobArg)
            mobArg:setUnkillable(false)
            mobArg:setHP(0)
        end)
    end
end

entity.onMobDespawn = function(mob)
    local ealdnarche = GetMobByID(mob:getID() - 1)

    if ealdnarche then
        ealdnarche:setUnkillable(false) -- Fail-safe.
        ealdnarche:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
        ealdnarche:delStatusEffect(xi.effect.ARROW_SHIELD)
        ealdnarche:delStatusEffect(xi.effect.MAGIC_SHIELD)
    end
end

return entity
