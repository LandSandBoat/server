-----------------------------------
-- Area: Batallia Downs (105)
--  Mob: Badshah
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- TODO: This is an assumption for despawn time

    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
