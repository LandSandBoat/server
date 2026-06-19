-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Qiqirn Astrologer
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, -1)
end

entity.onMobDisengage = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    local run   = mob:getLocalVar('run')
    local stage = instance:getStage()
    local prog  = instance:getProgress()

    if run == 1 then
        mob:pathThrough(ID.points[stage][prog - 1].point1, 9)
        mob:setLocalVar('run', 2)
    elseif run == 2 then
        mob:pathThrough(ID.points[stage][prog - 1].point2, 9)
        mob:setLocalVar('run', 3)
    elseif run == 3 then
        mob:pathThrough(ID.points[stage][prog - 1].point3, 9)
        mob:setLocalVar('run', 4)
    elseif run == 4 then
        mob:pathThrough(ID.points[stage][prog - 1].point4, 9)
        mob:setLocalVar('run', 5)
    elseif run == 5 then
        mob:pathThrough(ID.points[stage][prog - 1].point5, 9)
        mob:setLocalVar('run', 6)
    elseif run == 6 then
        mob:pathThrough(ID.points[stage][prog - 1].point6, 11)
        mob:setLocalVar('run', 7)
    end
end

entity.onMobEngage = function(mob)
    mob:setLocalVar('runTime', GetSystemTime())
end

entity.onMobFight = function(mob, target)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    local runTime = mob:getLocalVar('runTime')
    local stage   = instance:getStage()
    local prog    = instance:getProgress()

    if not mob:isFollowingPath() then
        if GetSystemTime() - runTime > 10 then
            if not xi.combat.behavior.isEntityBusy(mob) then
                if mob:getLocalVar('run') <= 1 then
                    mob:setLocalVar('run', 1)
                    mob:setLocalVar('runTime', GetSystemTime())
                    entity.onMobDisengage(mob)
                elseif mob:getLocalVar('run') <= 6 then
                    mob:setLocalVar('runTime', GetSystemTime())
                    entity.onMobDisengage(mob)
                end
            end
        end
    end

    if
        mob:getLocalVar('run') == 7 and
        mob:atPoint(ID.points[stage][prog - 1].point6)
    then
        mob:setLocalVar('run', 8)
        mob:setAutoAttackEnabled(false)
        mob:clearActionQueue()
        mob:castSpell(xi.magic.spell.WARP, mob)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        mob:timer(5000, function(mobArg)
            DespawnMob(mobArg:getID(), instance)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        xi.salvage.spawnTempChest(mob, {}, true)
    end
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('run', 0)
end

return entity
