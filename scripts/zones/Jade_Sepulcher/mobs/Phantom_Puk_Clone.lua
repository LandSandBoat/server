-----------------------------------
-- Area: Jade Sepulcher
--   NM: Phantom Puk (Clone)
-----------------------------------
mixins = { require('scripts/mixins/families/puk') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addStatusEffect(xi.effect.BLINK, 3, 0, 180)
    mob:setMod(xi.mod.DMG, 20000)
    mob:setMod(xi.mod.HP, 0)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
