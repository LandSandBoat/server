-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  Mob: Wulgaru (ZMN T2)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

return entity
