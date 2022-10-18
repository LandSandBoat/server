-----------------------------------
-- Area: Konschtat Highlands
--   NM: Tremor Ram
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
require("scripts/globals/mobs")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    -- If Steelflect doesn't pop next, fallback onto Rampaging Ram
    if not xi.mob.phOnDespawn(mob, ID.mob.STEELFLEECE_PH, 10, 75600) then -- 21 hours
        xi.mob.phOnDespawn(mob, ID.mob.RAMPAGING_RAM_PH, 10, 1200) -- 20 min
    end
end

return entity
