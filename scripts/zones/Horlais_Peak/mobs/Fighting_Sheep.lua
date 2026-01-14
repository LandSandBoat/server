-----------------------------------
-- Area: Horlais Peak
--  Mob: Fighting Sheep
-- BCNM: Hostile Herbivores
-- Note: melee attacks cause knockback. This is handled as a mobskill substitution.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setMod(xi.mod.BIND_RES_RANK, 8)
end

entity.onMobSpawn = function(mob)
    mob:setMobSkillAttack(701) -- Uses Sheep Charge as its' melee attack
end

return entity
