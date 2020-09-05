-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamia No.19
-----------------------------------
mixins = {require("scripts/mixins/weapon_break")}

function onMobEngaged(mob, target)
    local mobId = mob:getID()
    SpawnMob(mobId+1):updateEnmity(target)
    SpawnMob(mobId+2):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller)
end
