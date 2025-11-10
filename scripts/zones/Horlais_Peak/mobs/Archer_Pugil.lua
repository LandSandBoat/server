-----------------------------------
-- Area: Horlais Peak
--  Mob: Archer Pugil
-- BCNM Fight: Shooting Fish
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setBehavior(xi.behavior.STANDBACK)
    mob:setMobMod(xi.mobMod.STANDBACK_RANGE, 12)
    mob:setMobSkillAttack(2088) -- Will use Counterspore as their auto-attack.
end

return entity
