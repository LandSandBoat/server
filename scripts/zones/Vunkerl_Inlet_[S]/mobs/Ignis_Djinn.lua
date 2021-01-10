-----------------------------------
-- Area: Vunkerl Inlet [S]
--  Mob: Ignis Djinn
-- Note: PH for Big Bang
-----------------------------------
local ID = require("scripts/zones/Vunkerl_Inlet_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BIG_BANG_PH, 10, 3600) -- 1 hour
end

return entity
