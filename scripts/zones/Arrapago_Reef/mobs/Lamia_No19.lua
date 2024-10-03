-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamia No.19
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.weapon_break)
end

entity.onMobEngage = function(mob, target)
    local mobId = mob:getID()
    SpawnMob(mobId + 1):updateEnmity(target)
    SpawnMob(mobId + 2):updateEnmity(target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
