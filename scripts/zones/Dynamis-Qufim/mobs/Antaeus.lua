-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Antaeus
-- Note: Mega Boss
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, xi.mobSkill.TREBUCHET_2)
end

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
    mob:setLocalVar('[2hour]HPP', math.randomInt(70, 80))
    mob:setLocalVar('[2hour]Used', 0)
    mob:setLocalVar('nextTrebuchetTime', 0)
end

entity.onMobFight = function(mob, target)
    -- 2 Hour.
    if
        mob:getLocalVar('[2hour]Used') == 0 and
        mob:getHPP() < mob:getLocalVar('[2hour]HPP')
    then
        mob:setLocalVar('[2hour]Used', 1)
        mob:useMobAbility(xi.mobSkill.EES_ANTAEUS)
        return
    end

    if not target then
        return
    end

    local canUseTrebuchet =
        mob:checkDistance(target) > mob:getMeleeRange(target) and
        GetSystemTime() >= mob:getLocalVar('nextTrebuchetTime')
    local specialSkill = canUseTrebuchet and xi.mobSkill.TREBUCHET_2 or 0
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, specialSkill)
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    if skill:getID() == xi.mobSkill.TREBUCHET_2 then
        mob:setLocalVar('nextTrebuchetTime', GetSystemTime() + 10)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.POWER_ATTACK_3,
        xi.mobSkill.LIGHTNING_ROAR_2,
        xi.mobSkill.IMPACT_ROAR_2,
        xi.mobSkill.GRAND_SLAM_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
end

return entity
