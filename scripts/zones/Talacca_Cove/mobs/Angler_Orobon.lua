-----------------------------------
-- Area: Talacca Cove
--  Mob: Angler Orobon
-----------------------------------
mixins = { require('scripts/mixins/families/orobon') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 25)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
    mob:setMod(xi.mod.UDMGMAGIC, -1250)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 30)
    mob:setMod(xi.mod.STORETP, 100) -- 8 hits to 1000 TP
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    if
        target == mob:getTarget() and
        skill:getID() == xi.mobSkill.HYPNIC_LAMP
    then
        mob:useMobAbility(xi.mobSkill.DEATHGNASH)
    end
end

return entity
