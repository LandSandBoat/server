-----------------------------------
-- Area: Outer Horutoto Ruins (194)
--  Mob: Balloon
-- Note: PH for Bomb King, Doppelganger Dio, and Doppelganger Gog
-----------------------------------
local func = require("scripts/zones/Outer_Horutoto_Ruins/globals")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    func.balloonOnDespawn(mob)
end

return entity
