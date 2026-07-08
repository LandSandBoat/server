-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Huginn (Einherjar; Special mob)
-- Notes: Huginn drops an armoury crate when defeated which contains various temporary items.
-- Temporary items are chosen randomly from a pool of items. The quantity for each item is also random.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 8)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 60)
    mob:setMobMod(xi.mobMod.ROAM_RATE, 5)
end

entity.onMobSpawn = function(mob)
    -- Despawn special mob after 5 minutes
    mob:timer(300 * 1000, function(m)
        if m and m:isSpawned() then
            DespawnMob(m:getID())
        end
    end)

    -- Death drops the armoury crate
    mob:addListener('DEATH', 'EINHERJAR_DEATH', xi.einherjar.onSpecialMobDeath)

    -- Generic engage handler
    mob:addListener('ENGAGE', 'EINHERJAR_ENGAGE', xi.einherjar.onMobEngage)
end

return entity
