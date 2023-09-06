-----------------------------------
-- Area: Outer Horutoto Ruins
--   NM: Jack of Coins
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('popTime', os.time())
end

entity.onMobRoam = function(mob)
    if os.time() - mob:getLocalVar('popTime') > 180 then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
