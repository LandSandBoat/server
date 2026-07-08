-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Fairy Ring
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
    mob:setBaseSpeed(70)
    mob:setMobSkillAttack(2008) -- use mephitic spare as its auto attack
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MODIFIER, 165) -- Level 85 + 2 + 165 = 252 Base damage
end

return entity
