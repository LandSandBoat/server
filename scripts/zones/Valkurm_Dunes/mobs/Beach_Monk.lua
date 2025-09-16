-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Beach Monk
-- Part of Pirate's chart miniquest fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.piratesChart.onMobSpawn(mob)
end

entity.onMobFight = function(mob, target)
    xi.piratesChart.onMobFight(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.piratesChart.onMobDeath(mob, player, optParams)
end

return entity
