-----------------------------------
-- Area: Xarcabard
--   NM: Barbaric Weapon
-- TODO: "Gains a Dread Spikes effect whenever Whirl of Rage is used."
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.STORETP, 50) -- "Possesses extremely high Store TP."
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 318)
end

return entity
