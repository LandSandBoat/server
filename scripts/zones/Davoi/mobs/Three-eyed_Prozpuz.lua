-----------------------------------
-- Area: Davoi
--  Mob: Three-eyed Prozpuz
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 9)

    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 350)
    mob:setMod(xi.mod.STORETP, 60) -- 8 hits to 1000 TP
    mob:setMod(xi.mod.ATT, 240)
    mob:setMod(xi.mod.RATT, 170)
end

return entity
