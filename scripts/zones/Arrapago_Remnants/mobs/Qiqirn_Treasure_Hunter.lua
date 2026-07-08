-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Qiqirn Treasure Hunter
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobRoamAction = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    local stage = instance:getStage()
    local prog = instance:getProgress()

    if not mob:isFollowingPath() then
        mob:setBaseSpeed(40)
        mob:pathThrough(ID.points[stage][prog].route, 9)
    end
end

entity.onMobEngage = function(mob, target)
    if target:isPC() or target:isPet() then
        mob:setLocalVar('runTime', GetSystemTime())
    end
end

entity.onMobFight = function(mob, target)
    local instance = mob:getInstance()
    -- local stage = instance:getStage()
    -- local prog = instance:getProgress()
    local runTime = mob:getLocalVar('runTime')
    local popTime = mob:getLocalVar('popTime')
    local mobPos  = mob:getPos()
    local mobPet  = GetMobByID((mob:getID() + 1), instance)

    if not mob:isFollowingPath() and (GetSystemTime() - runTime > 20) then
        mob:setLocalVar('runTime', GetSystemTime())
        entity.onMobRoamAction(mob)
    elseif mob:isFollowingPath() then
        if
            mobPet and
            GetSystemTime() - popTime > 7
        then
            mobPet:updateEnmity(target)
            mobPet:setPos(mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
            mob:setLocalVar('popTime', GetSystemTime())
            mobPet:setStatus(xi.status.UPDATE)
            mobPet:timer(1000, function(mobArg)
                mobArg:useMobAbility(1838)
            end)

            mobPet:timer(4000, function(mobArg)
                mobArg:setStatus(xi.status.DISAPPEAR)
            end)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local instance = mob:getInstance()
    DespawnMob(mob:getID() + 1, instance) -- despawn bomb
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('runTime', 0)
end

return entity
