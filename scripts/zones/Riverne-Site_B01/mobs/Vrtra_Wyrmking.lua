-----------------------------------
-- Area: Riverne Site B01
-- Note: Weaker version of Vrtra summoned by Bahamut during The Wyrmking Descends
-----------------------------------
require('scripts/globals/follow')
-----------------------------------
---@type TMobEntity
local entity = {}

local petIDOffsets = { 7, 9, 11, 8, 10, 12 }

local spawnPet = function(vrtra, pet)
    vrtra:entityAnimationPacket(xi.animationString.CAST_SUMMONER_START)
    vrtra:setAutoAttackEnabled(false)
    vrtra:setMagicCastingEnabled(false)
    vrtra:setMobAbilityEnabled(false)
    vrtra:setMobMod(xi.mobMod.NO_MOVE, 1)

    vrtra:timer(3000, function(vrtraArg)
        vrtraArg:entityAnimationPacket(xi.animationString.CAST_SUMMONER_STOP)
        vrtraArg:setAutoAttackEnabled(true)
        vrtraArg:setMagicCastingEnabled(true)
        vrtraArg:setMobAbilityEnabled(true)
        vrtraArg:setMobMod(xi.mobMod.NO_MOVE, 0)

        if vrtraArg:isAlive() then
            local vrtraPos = vrtraArg:getPos()
            pet:setSpawn(vrtraPos.x, vrtraPos.y, vrtraPos.z, vrtraPos.rot)
            pet:spawn()
            if vrtraArg:isEngaged() and vrtraArg:getTarget() then
                pet:updateEnmity(vrtraArg:getTarget())
            end
        end
    end)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DEF, 436)
    mob:setMod(xi.mod.ATT, 281)
    mob:setMod(xi.mod.EVA, 371)
    mob:setMod(xi.mod.ACC, 359)
    mob:setMod(xi.mod.UFASTCAST, 40)
    mob:setMod(xi.mod.DARK_MEVA, 100)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -4000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 137)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 40)
    mob:setMod(xi.mod.REGEN, 50)
    mob:setMod(xi.mod.REFRESH, 100)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('addSpawnTime', 0)
    mob:setLocalVar('charmTime', 0)
    -- if engaged then send pets at target
    for i, petIDOffset in ipairs(petIDOffsets) do
        local pet = GetMobByID(mob:getID() + petIDOffset)
        if pet and pet:isAlive() then
            local mobTarget = mob:getTarget()
            if mobTarget then
                pet:updateEnmity(mobTarget)
            end
        end
    end
end

entity.onMobFight = function(mob, target)
    local addSpawnTime = mob:getLocalVar('addSpawnTime')
    local charmTime = mob:getLocalVar('charmTime')
    local battleTime = mob:getBattleTime()

    if charmTime == 0 then
        mob:setLocalVar('charmTime', battleTime + math.random(5, 7))
    end

    if addSpawnTime == 0 then
        mob:setLocalVar('addSpawnTime', battleTime + math.random(50, 70))
    end

    if
        battleTime > charmTime and
        mob:checkDistance(target) < 17 and
        mob:canUseAbilities()
    then
        mob:useMobAbility(710)
        -- Spams Charm in bv2 version roughly every 5s
        -- (see https://youtu.be/YHBfqLpGsp0?t=544)
        mob:setLocalVar('charmTime', battleTime + math.random(3, 7))
    elseif battleTime > addSpawnTime then
        local mobId = mob:getID()

        for _, petIDOffset in ipairs(petIDOffsets) do
            local pet = GetMobByID(mobId + petIDOffset)

            if pet and not pet:isSpawned() then
                spawnPet(mob, pet)
                break
            end
        end

        mob:setLocalVar('addSpawnTime', battleTime + math.random(50, 70))
    end
end

entity.onMobDeath = function(mob, player, optParams)
    for i, petIDOffset in ipairs(petIDOffsets) do
        local pet = GetMobByID(mob:getID() + petIDOffset)
        if pet and pet:isAlive() then
            pet:setHP(0)
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENDARK, { power = math.random(45, 90), chance = 10 })
end

return entity
