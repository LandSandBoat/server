-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Cirrate Christelle
-- Note: Mega Boss
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobSkillAttack(2010)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 50)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    -- TODO: Need to implement skill ID changes based on which NMs were killed. Needs more captures.
end

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
end

return entity
