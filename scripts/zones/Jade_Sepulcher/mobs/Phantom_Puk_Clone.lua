-----------------------------------
-- Area: Jade Sepulcher
--   NM: Phantom Puk (Clone)
-----------------------------------
mixins = { require('scripts/mixins/families/puk') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.WIND_ABSORB, 100)
end

entity.onMobSpawn = function(mob)
    mob:addStatusEffect(xi.effect.BLINK, 3, 0, 180)
    mob:setMod(xi.mod.DMG, 10000)
    mob:setMod(xi.mod.HP, 0)
end

return entity
