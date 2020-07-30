-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Qiqirn Treasure Hunter
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
-----------------------------------

function onMobRoamAction(mob)

    local instance = mob:getInstance()
    local stage = instance:getStage()
    local prog = instance:getProgress()

    if (mob:isFollowingPath() == false) then
        mob:speed(40)
        mob:pathThrough(ID.points[stage][prog].route, 9)
    end
end

function onMobEngaged(mob, target)

    local target = mob:getTarget()

    if (target:isPC() or target:isPet()) then
        mob:setLocalVar("runTime", os.time())
    end

end

function onMobFight(mob, target)

    local act = mob:getCurrentAction()
    local isBusy = false
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local prog = instance:getProgress()
    local runTime = mob:getLocalVar("runTime")
    local popTime = mob:getLocalVar("popTime")
    local POS = mob:getPos()
    local PET = instance:getEntity(bit.band((mob:getID()+1), 0xFFF), tpz.objType.MOB)

    if act == tpz.act.MOBABILITY_START or act == tpz.act.MOBABILITY_USING or act == tpz.act.MOBABILITY_FINISH or act == tpz.act.MAGIC_START or act == tpz.act.MAGIC_CASTING or act == tpz.act.MAGIC_START then
        isBusy = true -- is set to true if mob is in any stage of using a mobskill or casting a spell
    end

    if ((mob:isFollowingPath() == false) and (os.time() - runTime > 20)) then
        mob:setLocalVar("runTime", os.time())
        onMobRoamAction(mob)
    elseif (mob:isFollowingPath() == true) then
        if (os.time() - popTime > 7) then
            PET:updateEnmity(target)
            PET:setPos(POS.x, POS.y, POS.z, POS.rot)
            mob:setLocalVar("popTime", os.time())
            PET:setStatus(tpz.status.UPDATE)
            PET:timer(1000, function(mob) mob:useMobAbility(1838) end)
            PET:timer(4000, function(mob) mob:setStatus(tpz.status.DISAPPEAR) end)
        end
    end
end

function onMobDeath(mob, player, isKiller)
    DespawnMob(mob:getID() +1, instance) -- despawn bomb
end

function onMobDespawn(mob)
    mob:setLocalVar("runTime", 0)
end
