-----------------------------------
-- Area: Horlais Peak
--  Mob: Archer Pugil
-- BCNM: Shooting Fish
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobSkillAttack(412)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
