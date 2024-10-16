-----------------------------------
-- Area: Horlais Peak
--  Mob: Archer Pugil
-- BCNM: Shooting Fish
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobSkillAttack(2014) -- Aquaball Knockback AA Skill
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
