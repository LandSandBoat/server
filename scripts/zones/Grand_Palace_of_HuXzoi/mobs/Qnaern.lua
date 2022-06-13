-----------------------------------
-- Area: Grand Palace of HuXzoi
--   NM: Qn'aern
-- Note: The RDM and WHM versions in Palace assist Ix'Aern (MNK)
--       All Qn'aerns can use their respective two-hour abilities multiple times (guessing 2-minute timers)
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
