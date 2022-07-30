-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Memory Receptacles
-----------------------------------
local ID = require("scripts/zones/Spire_of_Vahzl/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/battlefield")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    local position = math.random(1, 8)
    mob:setLocalVar("positionNum", position) -- Set random Orb spawn positions
    mob:setLocalVar("tpNumber", 0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:addStatusEffectEx(xi.effect.MAGIC_SHIELD, 0, 1, 0, 0)
    mob:setMod(xi.mod.UDMGRANGE, -10001)
    mob:setMod(xi.mod.UDMGPHYS, -10001)
    mob:SetAutoAttackEnabled(false)
end

entity.onMobEngaged = function(mob, target)
    local battlefield = mob:getBattlefield()
    local bfID = battlefield:getArea()
    SpawnMob(ID.pullingThePlug[bfID].GREEN_ID):updateEnmity(target)
    SpawnMob(ID.pullingThePlug[bfID].BLUE_ID):updateEnmity(target)
    SpawnMob(ID.pullingThePlug[bfID].TEAL_ID):updateEnmity(target)

    mob:setMod(xi.mod.REGAIN, 450)
    mob:setLocalVar("drawInTime", os.time() + 20)
    battlefield:setLocalVar("moveTime", os.time() + 30)
end

entity.onMobWeaponSkillPrepare = function(target, mob, skill)
    local bfID = mob:getBattlefield():getArea()
    local tpNumber = mob:getLocalVar("tpNumber")
    local tpDelay = mob:getLocalVar("tpDelay")

    -- Every three Empty Seeds, all the orbs in the room simulatenously Empty Seed
    if tpNumber < 2 then
        mob:setLocalVar("tpNumber", tpNumber + 1)
    elseif tpNumber >= 2 and os.time() > tpDelay then
        GetMobByID(ID.pullingThePlug[bfID].GREEN_ID):useMobAbility(542)
        GetMobByID(ID.pullingThePlug[bfID].BLUE_ID):useMobAbility(542)
        GetMobByID(ID.pullingThePlug[bfID].TEAL_ID):useMobAbility(542)
        mob:setLocalVar("tpNumber", 0)
        mob:setLocalVar("tpDelay", os.time() + 10)
    end
end

entity.onMobFight = function(mob, target)
    -- Draws in random party member every 20 seconds
    local drawInTime = mob:getLocalVar("drawInTime")
    local party = target:getParty()

    if os.time() > drawInTime then
        local victim = math.random(1,#party)
        for k, v in pairs(party) do
            if v:isAlive() and k == victim and not v:isInEvent() then
                mob:triggerDrawIn(mob, false, 1, 35, v)
                mob:setLocalVar("drawInTime", os.time() + 20)
                break
            end
        end
    end

    -- Spawned orbs move to a random location every 30 seconds
    local battlefield = mob:getBattlefield()
    local moveTime = battlefield:getLocalVar("moveTime")

    if os.time() > moveTime then
        battlefield:setLocalVar("moveTime", os.time() + 30)
        local newPos = math.random(1,8)
        while newPos == mob:getLocalVar("positionNum") do
            newPos = math.random(1,8)
        end
        mob:setLocalVar("positionNum", math.random(1,8))
    end

    -- If an orb dies, remove its associated immunity
    if battlefield:getLocalVar("GreenDead") == 1 then
        mob:delStatusEffectSilent(xi.effect.MAGIC_SHIELD)
    end
    if battlefield:getLocalVar("BlueDead") == 1 then
        mob:setMod(xi.mod.UDMGRANGE, 0) -- Remove ranged immunity
    end
    if battlefield:getLocalVar("TealDead") == 1 then
        mob:setMod(xi.mod.UDMGPHYS, 0) -- Remove melee immunity
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    -- Despawn all other mobs
    for i = mob:getID() + 1, mob:getID() + 8 do
        DespawnMob(i)
    end
end

entity.onMobDespawn = function(mob)
    mob:resetLocalVars()
end

return entity
