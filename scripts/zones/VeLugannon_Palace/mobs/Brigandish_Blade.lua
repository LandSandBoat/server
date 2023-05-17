-----------------------------------
-- Area: VeLugannon Palace
--   NM: Brigandish Blade
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:setLocalVar("killable", 0)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TERROR, { chance = 30 })
end

entity.onMobFight = function(mob, target)
    local killable = mob:getLocalVar("killable")

    if mob:getHPP() == 1 and mob:getMod(xi.mod.DMG) == 0 and not killable then
        mob:setMod(xi.mod.DMG, -10000)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
