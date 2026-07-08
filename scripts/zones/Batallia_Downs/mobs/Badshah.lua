-----------------------------------
-- Area: Batallia Downs (105)
--  Mob: Badshah
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- TODO: This is an assumption for despawn time

    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

return entity
