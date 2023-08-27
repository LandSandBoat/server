-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Justice
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
require("scripts/globals/magic")
-----------------------------------
local entity = {}

local spawnXzomit = function(mob, xzomit)
    mob:entityAnimationPacket("casm")
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)
    local pos = mob:getPos()
    mob:timer(3000, function(mobArg)
        if mob:isAlive() then
            mobArg:entityAnimationPacket("shsm")
            mobArg:setAutoAttackEnabled(true)
            mobArg:setMobAbilityEnabled(true)
            GetMobByID(xzomit):setSpawn(pos.x + math.random(1, 2), pos.y, pos.z + math.random(1, 2))
            SpawnMob(xzomit):updateEnmity(mobArg:getTarget())
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("familiarTrigger", math.random(40, 60))
    mob:setLocalVar("canCharm", os.time() + 240)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < mob:getLocalVar("familiarTrigger") and mob:getLocalVar("familiar") == 0 then
        mob:setLocalVar("twohour_tp", mob:getTP())
        mob:useMobAbility(740)
        mob:setLocalVar("familiar", 1)
    end

    local popTime = mob:getLocalVar("lastPetPop")
    -- ffxiclopedia says 30 sec, bgwiki says 1-2 min..
    -- confirmed retail capture spawns xzomits every 30 seconds..
    if os.time() - popTime > 30 then
        local alreadyPopped = false
        for xzomit = ID.mob.QN_XZOMIT_START, ID.mob.QN_XZOMIT_END do
            if alreadyPopped == true then
                break
            else
                if
                    not GetMobByID(xzomit):isSpawned() and
                    mob:canUseAbilities() == true
                then
                    mob:setLocalVar("lastPetPop", os.time())
                    alreadyPopped = true
                    spawnXzomit(mob, xzomit)
                end
            end
        end
    end

    if os.time() > mob:getLocalVar("canCharm") then
        mob:setLocalVar("canCharm", os.time() + 240)
        mob:setLocalVar("twohour_tp", mob:getTP())
        mob:useMobAbility(710)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 740 then
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
    elseif skill:getID() == 710 then
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    for i = ID.mob.QN_XZOMIT_START, ID.mob.QN_XZOMIT_END do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end
end

return entity
