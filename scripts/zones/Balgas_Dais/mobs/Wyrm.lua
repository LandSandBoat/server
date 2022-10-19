-----------------------------------
-- Area: Balga's Dais
--  Mob: Wyrm
-- KSNM: Early Bird Catches the Wyrm
-- For future reference: Trusts are not allowed in this fight
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

local grounded = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.EVA, 50)
    mob:addMod(xi.mod.ATT, 100)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_INCLUDE_PARTY, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_IGNORE_STATIONARY, 1)
    mob:SetMobSkillAttack(0) -- resetting so it doesn't respawn in flight mode.
    mob:setAnimationSub(0) -- subanim 0 is only used when it spawns until first flight.
    mob:setTP(3000) -- opens fight with a skill
    mob:setLocalVar("state", 0)
    grounded(mob)
end

entity.onMobEngaged = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 100) -- very close to the capture by comparing stop watch measures
    mob:setMod(xi.mod.REGEN, 50)
end

entity.onMobFight = function(mob, target)
    local state = mob:getLocalVar("state")

    if state == 1 then -- Path to center of arena and fly
        local spawn = mob:getSpawnPos()
        local current = mob:getPos()
        local diffX = spawn.x - current.x
        local diffY = spawn.y - current.y
        local diffZ = spawn.z - current.z

        local distance = math.sqrt(math.pow(diffX, 2) + math.pow(diffY, 2) + math.pow(diffZ, 2))
        if distance < 3 then
            mob:setLocalVar("state", 2) -- fly state
            mob:setBehaviour(0)
            mob:setAnimationSub(1)
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:SetMobSkillAttack(1146)
        else
            mob:pathTo(spawn.x , spawn.y, spawn.z)
        end
    elseif state == 2 then
        mob:lookAt(target:getPos())
    end

    if mob:canUseAbilities() then
        -- Fly @ 66%
        if mob:getAnimationSub() == 0 and mob:getHPP() <= 66 and state == 0 then
            local spawn = mob:getSpawnPos()
            mob:pathTo(spawn.x , spawn.y, spawn.z)
            mob:setLocalVar("state", 1) -- moving to spawn
        -- Land @ 33%
        elseif mob:getAnimationSub() == 1 and mob:getHPP() <= 33 and state == 2 then
            mob:setLocalVar("state", 3) -- final state
            mob:useMobAbility(954)
            grounded(mob)
            mob:addStatusEffect(xi.effect.EVASION_BOOST, 50, 0, 0)
            mob:addStatusEffect(xi.effect.DEFENSE_BOOST, 50, 0, 0)
            mob:addStatusEffect(xi.effect.MAGIC_DEF_BOOST, 40, 0, 0)
        -- Ensure Wyrm lands if Touchdown is interrupted
        elseif mob:getAnimationSub() ~= 2 and state == 3 and mob:canUseAbilities() then
            mob:setAnimationSub(2)
            grounded(mob)
            mob:delStatusEffect(xi.effect.ALL_MISS)
            mob:SetMobSkillAttack(0)
        end
    end

    -- Wakeup from sleep immediately if flying
    if mob:getAnimationSub() == 1 and
       (mob:hasStatusEffect(xi.effect.SLEEP_I) or
       mob:hasStatusEffect(xi.effect.SLEEP_II) or
       mob:hasStatusEffect(xi.effect.LULLABY)) then
        mob:wakeUp()
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
