-----------------------------------
-- Area: Horlais Peak
--  Mob: Sniper Pugil
-- BCNM: Shooting Fish
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:SetMobSkillAttack(412)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
