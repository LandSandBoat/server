-----------------------------------
-- Area: Jugner Forest [S]
--  Mob: Cobraclaw Buchzvotch
-- Wrath of the Griffon Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

return entity
