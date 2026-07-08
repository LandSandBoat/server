-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Saehrimnir (Einherjar; Special mob)
-- Notes: Saehrimnir buffs chamber mobs (current and future waves) when left to despawn.
-- The buff effect is not yet entirely understood and may be random in nature.
-- It is believed to be an opposite of Muninn debuffs and may include the following:
-- - Lowered delay
-- - Increased PDT
-- - Increased MDT
-- - Regain effect
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

    -- Despawn triggers the buff effects
    mob:addListener('DESPAWN', 'EINHERJAR_DESPAWN', xi.einherjar.onSpecialMobDespawn)

    -- Generic engage handler
    mob:addListener('ENGAGE', 'EINHERJAR_ENGAGE', xi.einherjar.onMobEngage)
end

entity.onMobDeath = function(mob, player, isKiller)
    -- Defeating Saehrimnir will not trigger the despawn buff
    mob:removeListener('EINHERJAR_DESPAWN')
end

return entity
