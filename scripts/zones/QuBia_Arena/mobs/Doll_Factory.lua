-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Doll Factory
-- BCNM: Factory Rejects
-----------------------------------
---@type TMobEntity
local entity = {}

local callPetParams =
{
    maxPets        = 1,
    inactiveTime   = 5000,
    persistOnDeath = true,
}

entity.onMobInitialize = function(mob)
    -- Ensure the factory cannot be interrupted while summoning dolls
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setBehavior(xi.behavior.NO_TURN)
end

entity.onMobSpawn = function(mob)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- Set the Doll Factory ID here in a variable so Generic Dolls can access it on spawn
    battlefield:setLocalVar('factoryId', mob:getID())
end

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- When all 5 Generic Dolls have spawned, the factory dies on its' own - we increment this in Generic Doll.lua
    local dollsSpawned = battlefield:getLocalVar('dollsSpawned')
    if dollsSpawned >= 5 then
        mob:setHP(0)
        return
    end

    -- Check if the Generic Doll we summoned is still present in the battlefield, if so, return
    if dollsSpawned > 0 then
        local currentDoll = GetMobByID(mob:getID() + dollsSpawned)
        if currentDoll and currentDoll:isSpawned() then
            return
        end
    end

    -- If we are busy summoning a doll, return
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Summon the next Generic Doll
    if xi.mob.callPets(mob, mob:getID() + dollsSpawned + 1, callPetParams) then
        mob:setLocalVar('isBusy', 1) -- The summoned Generic Doll will set isBusy back to 0 for us, this way we can avoid any timer.
    end
end

entity.onMobDespawn = function(mob)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- If the Doll Factory despawns before all dolls are spawned, end the battle.
    if battlefield:getLocalVar('dollsSpawned') < 5 then
        battlefield:setTimeLimit(0)
    end
end

return entity
