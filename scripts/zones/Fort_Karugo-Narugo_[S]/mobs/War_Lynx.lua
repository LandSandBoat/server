-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--  Mob: War Lynx
-- The Tigress Strikes Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

return entity
