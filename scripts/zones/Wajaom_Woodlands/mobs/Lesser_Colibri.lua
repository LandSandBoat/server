-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Lesser Colibri
-- Note: Place holder Zoraal Ja's Pkuucha
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.ZORAAL_JA_S_PKUUCHA_PH, 5, math.random(1800, 43200)) -- 30 minutes to 12 hours
end
