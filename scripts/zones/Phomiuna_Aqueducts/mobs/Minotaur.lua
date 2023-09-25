-----------------------------------
-- Area: Phomiuna Aqueducts
--  Mob: Minotaur
-----------------------------------
mixins = { require("scripts/mixins/fomor_hate") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("fomorHateAdj", 2)

    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_INCLUDE_PARTY, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 10)
end

entity.onMobDrawIn = function(mob, target)
    local battleTarget = mob:getTarget()

    if target:getID() == battleTarget:getID() then
        mob:useMobAbility(({ 498, 499, 500, 501, 502 })[math.random(1, 5)]) -- triclip, back_swish, mow, frightful_roar, mortal_ray
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
