-----------------------------------
-- Area: Talacca Cove
--  Mob: Angler Orobon
-----------------------------------
mixins = { require('scripts/mixins/families/orobon') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 25)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == xi.mobSkill.HYPNIC_LAMP then
        mob:useMobAbility(xi.mobSkill.DEATHGNASH)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
