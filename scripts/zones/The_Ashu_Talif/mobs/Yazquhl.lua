-----------------------------------
-- Area: The Ashu Talif (Against All Odds)
--  Mob: Yazquhl
-----------------------------------
local ID = zones[xi.zone.THE_ASHU_TALIF]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setBehavior(xi.behavior.NO_DESPAWN)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 10)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 10)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.ACC, 290)
    mob:setMobMod(xi.mobMod.DETECTION, 0x002)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 10)
end

entity.onMobEngage = function(mob)
    mob:showText(mob, ID.text.YAZQUHL_ENGAGE)
    mob:setMod(xi.mod.REGAIN, 75)
end

entity.onMobFight = function(mob, target)
    -- Early return: No instance
    local instance = mob:getInstance()
    if not instance then
        return
    end

    -- Early return: No partner entity
    local gowam = GetMobByID(ID.mob.GOWAM, instance)
    if not gowam then
        return
    end

    -- Handle Skillchain opener
    local gowamTP = gowam:getTP()
    if
        gowamTP >= 1000 and
        mob:getTP() > gowamTP and
        not xi.combat.behavior.isEntityBusy(mob)
    then
        mob:useMobAbility()
    end

    -- Handle Skillchain closer
    if instance:getLocalVar('scReadyGowam') ~= 1 then
        return
    end

    instance:setLocalVar('scReadyGowam', 0)

    local scTarget = GetPlayerByID(instance:getLocalVar('scTargetGowam'))
    if not scTarget then
        return
    end

    mob:timer(4000, function(yazquhlMob)
        if
            yazquhlMob:getTP() < 1000 or
            not scTarget or
            scTarget:isDead() or
            yazquhlMob:checkDistance(scTarget) >= 25
        then
            yazquhlMob:setMobAbilityEnabled(true)
            return
        end

        yazquhlMob:useMobAbility(xi.mobSkill.VORPAL_BLADE_1, scTarget)
        mob:showText(mob, ID.text.REST_BENEATH)

        -- Only add Emnity if the skillchain closer target is different than its current target
        if
            gowam:isAlive() and
            gowam and scTarget ~= target
        then
            yazquhlMob:addEnmity(scTarget, gowam:getCE(scTarget), gowam:getVE(scTarget))
        end
    end)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local tpTable =
    {
        xi.mobSkill.FAST_BLADE_1,
        xi.mobSkill.BURNING_BLADE_1,
        xi.mobSkill.RED_LOTUS_BLADE_1,
        xi.mobSkill.SHINING_BLADE_1,
        xi.mobSkill.SERAPH_BLADE_1,
        xi.mobSkill.CIRCLE_BLADE_1,
    }

    local instance = mob:getInstance()
    if not instance then
        return
    end

    local gowam = GetMobByID(ID.mob.GOWAM, instance)
    if not gowam then
        return
    end

    if
        gowam:isDead() or
        gowam:getTP() < 1000 or
        mob:checkDistance(gowam) >= 25
    then
        table.insert(tpTable, xi.mobSkill.FLAT_BLADE_1)
        table.insert(tpTable, xi.mobSkill.VORPAL_BLADE_1)
    end

    local weaponskillMessage =
    {
        [1] = ID.text.TAKE_THIS,
        [2] = ID.text.REST_BENEATH,
        [3] = ID.text.STOP_US,
    }

    if mob:isEngaged() then
        mob:showText(mob, weaponskillMessage[math.random(1, #weaponskillMessage)])
    end

    return tpTable[math.random(1, #tpTable)]
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    if skill:getID() == xi.jsa.MIGHTY_STRIKES then
        mob:showText(mob, ID.text.YOU_WILL_REGRET)
    end

    mob:setMobAbilityEnabled(true)

    local instance = mob:getInstance()
    if not instance then
        return
    end

    local gowam = GetMobByID(ID.mob.GOWAM, instance)
    if
        gowam and
        gowam:isAlive() and
        mob:checkDistance(gowam) < 25
    then
        gowam:setMobAbilityEnabled(false)
        gowam:setMagicCastingEnabled(false)
        instance:setLocalVar('scReadyYazquhl', 1)
        instance:setLocalVar('scTargetYazquhl', target:getID())
    end
end

entity.onMobDisengage = function(mob)
    mob:showText(mob, ID.text.YAZQUHL_CORSAIR_COULD)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:showText(mob, ID.text.YAZQUHL_DEATH)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if instance then
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
