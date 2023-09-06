-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamia No.19
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    local mobId = mob:getID()
    SpawnMob(mobId + 1):updateEnmity(target)
    SpawnMob(mobId + 2):updateEnmity(target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
