-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamia No.19
-----------------------------------
mixins = {require("scripts/mixins/weapon_break")}
-----------------------------------
local entity = {}

function onMobEngaged(mob, target)
    local mobId = mob:getID()
    SpawnMob(mobId+1):updateEnmity(target)
    SpawnMob(mobId+2):updateEnmity(target)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
