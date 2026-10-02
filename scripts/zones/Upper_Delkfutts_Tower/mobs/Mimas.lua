-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Mimas
-- Note: Mob uses Hundred Fists but is WAR main job.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener('EFFECT_LOSE', 'HUNDRED_FISTS_LOSE', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.HUNDRED_FISTS then
            mobArg:setMobAbilityEnabled(true)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[2hour]HPP', math.randomInt(30, 60))
    mob:setLocalVar('[2hour]Used', 0)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if mob:getLocalVar('[2hour]Used') ~= 0 then
        return
    end

    if mob:getHPP() >= mob:getLocalVar('[2hour]HPP') then
        return
    end

    mob:setLocalVar('[2hour]Used', 1)
    mob:useMobAbility(xi.mobSkill.HUNDRED_FISTS_1)
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    if skill:getID() == xi.mobSkill.HUNDRED_FISTS_1 then
        mob:setMobAbilityEnabled(false)
    end
end

return entity
