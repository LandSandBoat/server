-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Garm
-- Note: PH for Shii
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 612, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SHII_PH, 5, 3600) -- 1 hour
end

return entity
