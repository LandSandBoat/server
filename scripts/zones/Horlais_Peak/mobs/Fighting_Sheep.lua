-----------------------------------
-- Area: Horlais Peak
--  Mob: Fighting Sheep
-- BCNM: Hostile Herbivores
-- Note: melee attacks cause knockback. This is handled as a mobskill substitution.
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.ICE_MEVA, 75) -- Todo: Move to mob_resists.sql
end

entity.onMobSpawn = function(mob)
    mob:setMobSkillAttack(701)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    mob:setLocalVar("skill_tp", mob:getTP())
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 274 then
        mob:addTP(mob:getLocalVar("skill_tp"))
        mob:setLocalVar("skill_tp", 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
