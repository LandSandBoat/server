-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Labyrinth Manticore
-- Note: Place holder Narasimha
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 775, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.NARASIMHA_PH, 10, 21600) -- 6 to 10 hours
end

return entity
