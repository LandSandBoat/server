-----------------------------------
-- Area: Rolanberry Fields
--   NM: Silk Caterpillar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- Despawns 3.5 minutes after spawning, approximately when the Jeuno-Bastok airship departs Jeuno to fly back over towards Bastok.
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 210)
end

return entity
