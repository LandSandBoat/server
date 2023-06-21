-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Qiqirn Astrologer
-----------------------------------
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
require("scripts/globals/mobskills")
require("scripts/globals/teleports")
require("scripts/globals/pathfind")
require("scripts/globals/msg")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, -1)
end

entity.onMobDisengage = function(mob)
    local run = mob:getLocalVar("run")
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local prog = instance:getProgress()

    if run == 1 then
        mob:pathThrough(ID.points[stage][prog - 1].point1, 9)
        mob:setLocalVar("run", 2)
    elseif run == 2 then
        mob:pathThrough(ID.points[stage][prog - 1].point2, 9)
        mob:setLocalVar("run", 3)
    elseif run == 3 then
        mob:pathThrough(ID.points[stage][prog - 1].point3, 9)
        mob:setLocalVar("run", 4)
    elseif run == 4 then
        mob:pathThrough(ID.points[stage][prog - 1].point4, 9)
        mob:setLocalVar("run", 5)
    elseif run == 5 then
        mob:pathThrough(ID.points[stage][prog - 1].point5, 9)
        mob:setLocalVar("run", 6)
    elseif run == 6 then
        mob:pathThrough(ID.points[stage][prog - 1].point6, 9)
        mob:setLocalVar("run", 7)
    end
end

entity.onMobEngaged = function(mob)
    mob:setLocalVar("runTime", os.time())
end

entity.onMobFight = function(mob, target)
    local act = mob:getCurrentAction()
    local isBusy = false
    local runTime = mob:getLocalVar("runTime")
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local prog = instance:getProgress()

    if
        act == xi.act.MOBABILITY_START or
        act == xi.act.MOBABILITY_USING or
        act == xi.act.MOBABILITY_FINISH or
        act == xi.act.MAGIC_START or
        act == xi.act.MAGIC_CASTING or
        act == xi.act.MAGIC_START
    then
        isBusy = true -- is set to true if mob is in any stage of using a mobskill or casting a spell
    end

    if not mob:isFollowingPath() then
        if os.time() - runTime > 10 then
            if mob:actionQueueEmpty() and not isBusy then
                if mob:getLocalVar("run") <= 1 then
                    mob:setLocalVar("run", 1)
                    mob:setLocalVar("runTime", os.time())
                    entity.onMobDisengage(mob)
                elseif mob:getLocalVar("run") <= 6 then
                    mob:setLocalVar("runTime", os.time())
                    entity.onMobDisengage(mob)
                elseif mob:getLocalVar("run") == 7 then
                    DespawnMob(ID.mob[stage - 1][prog - 1].astrologer, instance)
                end
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar("run", 0)
end

return entity
