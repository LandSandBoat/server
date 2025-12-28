-----------------------------------
-- Area: Outer Horutoto Ruins
--   NM: Jack of Coins
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('popTime', GetSystemTime())
end

entity.onMobRoam = function(mob)
    if GetSystemTime() - mob:getLocalVar('popTime') > 180 then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
