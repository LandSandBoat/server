-----------------------------------
-- Area: Caedarva Mire
--   NM: Zikko
-- !pos -608.5 11.3 -186.5 79
-----------------------------------
mixins = { require('scripts/mixins/families/imp') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setLocalVar('cooldown', GetSystemTime())
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 469)
end

entity.onMobDespawn = function(mob)
    local respawn = math.random(60, 75) * 60 -- 60 to 75 minutes
    mob:setLocalVar('cooldown', GetSystemTime() + respawn)
end

return entity
