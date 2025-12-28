-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Heithrun (Einherjar; Special mob)
-- Notes: Heithrun grants various bonuses to the final armoury crate when defeated.
-- Effects include:
--  - Doubling the number of items (2x boss drops, up to 6x crafting items)
--  - Increasing the rate of abjuration items (including the secondary roll)
--  - Special unique items specific to Heithrun
-- TODO: The effect is not yet implemented
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

    -- Death triggers the buff effect
    mob:addListener('DEATH', 'EINHERJAR_DEATH', xi.einherjar.onSpecialMobDeath)

    -- Generic engage handler
    mob:addListener('ENGAGE', 'EINHERJAR_ENGAGE', xi.einherjar.onMobEngage)
end

return entity
