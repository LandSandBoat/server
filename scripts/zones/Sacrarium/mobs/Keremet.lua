-----------------------------------
-- Area: Sacrarium
--   NM: Keremet
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobFight = function(mob, target)
    -- Send spawned skeleton "pets" to Keremet's target.
    local keremetId  = mob:getID()
    for i = keremetId + 1, keremetId + 12 do
        local keremetSkeleton = GetMobByID(i)

        if
            keremetSkeleton and
            keremetSkeleton:getCurrentAction() == xi.action.category.ROAMING
        then
            keremetSkeleton:updateEnmity(target)
        end
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(1200, 1800)) -- 20 to 30 minutes
end

return entity
