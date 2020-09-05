-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Qiqirn Astrologer
-----------------------------------
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
require("scripts/globals/monstertpmoves")
require("scripts/globals/teleports")
require("scripts/globals/pathfind")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onMobSpawn(mob)
   mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end

function onMobDisengage(mob)
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

function onMobEngaged(mob)
    mob:setLocalVar("runTime", os.time())
end

function onMobFight(mob, target)
    local act = mob:getCurrentAction()
    local isBusy = false
    local runTime = mob:getLocalVar("runTime")
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local prog = instance:getProgress()

    if act == tpz.act.MOBABILITY_START or act == tpz.act.MOBABILITY_USING or act == tpz.act.MOBABILITY_FINISH or act == tpz.act.MAGIC_START or act == tpz.act.MAGIC_CASTING or act == tpz.act.MAGIC_START then
        isBusy = true -- is set to true if mob is in any stage of using a mobskill or casting a spell
    end

    if mob:isFollowingPath() == false then
        if (os.time() - runTime > 10) then
            if (mob:actionQueueEmpty() == true and isBusy == false) then
                if mob:getLocalVar("run") <= 1 then
                    mob:setLocalVar("run", 1)
                    mob:setLocalVar("runTime", os.time())
                    onMobDisengage(mob)
                elseif mob:getLocalVar("run") <= 6 then
                    mob:setLocalVar("runTime", os.time())
                    onMobDisengage(mob)
                elseif mob:getLocalVar("run") == 7 then
                    DespawnMob(ID.mob[stage - 1][prog - 1].astrologer, instance)
                end
            end
        end
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setLocalVar("run", 0)
end
