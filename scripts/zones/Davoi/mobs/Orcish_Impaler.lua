-----------------------------------
-- Area: Davoi
--  Mob: Orcish Impaler
-- Note: PH for Poisonhand Gnadgad and Steelbiter Gudrud
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.POISONHAND_GNADGAD_PH, 10, 3600) -- 1 hour
    xi.mob.phOnDespawn(mob, ID.mob.STEELBITER_GUDRUD_PH, 10, 3600) -- 1 hour
end

return entity
