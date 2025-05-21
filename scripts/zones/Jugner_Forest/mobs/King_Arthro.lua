-----------------------------------
-- Area: Jugner Forest
--   NM: King Arthro
-----------------------------------
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/rage')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.UFASTCAST, 100)
    mob:setMobMod(xi.mobMod.GIL_MIN, 15000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CANNOT_GUARD, 1)
    local kingArthroID = mob:getID()

    -- Use King Arthro ID to determine Knight Crab Id's, then set their respawn to 0 so they don't spawn while KA is up
    for offset = 1, 10 do
        GetMobByID(kingArthroID - offset):setRespawnTime(0)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    if mob:hasStatusEffect(xi.effect.ENWATER) then
        return 0, 0, 0
    else
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())

    local kingArthroID = mob:getID()

    GetMobByID(kingArthroID):setLocalVar('[POP]King_Arthro', 0)

    -- Set respawn of 21:05 to 24:05
    local respawnTime = 75900 + math.random(0, 6) * 1800 -- 21:05 to 24:05 respawn timer in 30 minute intervals
    for offset = 1, 10 do
        GetMobByID(kingArthroID - offset):setRespawnTime(respawnTime)
    end
end

return entity
