-----------------------------------
-- Area: Manaclipper
--   NM: Zoredonite
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/families/uragnite")
}
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, player)
    mob:setLocalVar("[uragnite]inShellRegen", 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, 43200) -- 12 hour respawn
end

return entity
