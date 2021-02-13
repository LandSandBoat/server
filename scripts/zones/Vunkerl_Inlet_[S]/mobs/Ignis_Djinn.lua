-----------------------------------
-- Area: Vunkerl Inlet [S]
--  Mob: Ignis Djinn
-- Note: PH for Big Bang
-----------------------------------
local ID = require("scripts/zones/Vunkerl_Inlet_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BIG_BANG_PH, 10, 3600) -- 1 hour
end

return entity
