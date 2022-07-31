-----------------------------------
-- Area: Grand Palace of HuXzoi
--   NM: Qn'aern
-- Note: The RDM and WHM versions in Palace assist Ix'Aern (MNK)
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
