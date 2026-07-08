-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Muninn (Einherjar; Special mob)
-- Notes: Muninn debuffs all chamber mobs when defeated (current and future waves).
-- The debuff effect is not yet entirely understood and may be random in nature.
-- Observed effects include:
--  - Increased physical and magical damage taken
--  - Increased delay (between 50% and 150%)
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

    -- Death triggers the debuff effects
    mob:addListener('DEATH', 'EINHERJAR_DEATH', xi.einherjar.onSpecialMobDeath)

    -- Generic engage handler
    mob:addListener('ENGAGE', 'EINHERJAR_ENGAGE', xi.einherjar.onMobEngage)
end

return entity
