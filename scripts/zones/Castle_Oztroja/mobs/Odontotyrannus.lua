-----------------------------------
-- Area: Castle Oztroja (151)
--  NM: Odontotyrannus
-- Fished up in Quests: A Boy's Dream
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
    mob:setMod(xi.mod.STORETP, 125) -- 6 hits to 1ktp
    mob:setMod(xi.mod.ATT, 125)
end

return entity
