-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Stcemqestcint
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobSkillAttack(2012) -- use gouging_branch as its auto attack
end

return entity
