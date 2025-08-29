-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Beach Monk
-- Part of Pirate's chart miniquest fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobFight = function(mob, target)
    return xi.piratesChart.onMobFight(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    return xi.piratesChart.onMobDeath(mob, player, optParams)
end

return entity
