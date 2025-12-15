-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Vaicoliaux B D'Aurphe
-- BCNM: Brothers D'Aurphe
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.EVASION_DOWN)
end

return entity
