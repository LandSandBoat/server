-----------------------------------
-- Area: Pso'Xja
--  Mob: Nunyunuwi
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 150)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
