-----------------------------------
-- Area: Konschtat Highlands
--   NM: Tremor Ram
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
require("scripts/globals/mobs")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.tutorial.onMobDeath(player)
end

function onMobDespawn(mob)
    -- If Steelflect doesn't pop next, fallback onto Rampaging Ram
    if not tpz.mob.phOnDespawn(mob, ID.mob.STEELFLEECE_PH, 10, math.random(75600, 86400)) then -- 21-24 hours
        tpz.mob.phOnDespawn(mob, ID.mob.RAMPAGING_RAM_PH, 10, 1200) -- 20 min
    end
end

return entity
