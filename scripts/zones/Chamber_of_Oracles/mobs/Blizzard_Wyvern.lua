-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Blizzard Wyvern
-- KSNM: Eye of the Storm
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 17)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobEngage = function(mob, target)
    mob:useMobAbility(xi.mobSkill.WIND_WALL)
end

return entity
