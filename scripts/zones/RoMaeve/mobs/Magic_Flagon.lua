-----------------------------------
-- Area: RoMaeve
--  Mob: Magic Flagon
-- Note: PH for Nightmare Vase and Rogue Receptacle
-- TODO: Nightmare Vase and Rogue Receptacle PHs should be in spawn groups
-----------------------------------
local ID = zones[xi.zone.ROMAEVE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 120, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.NIGHTMARE_VASE[1], 10, 3600) -- 1 hour
    xi.mob.phOnDespawn(mob, ID.mob.ROGUE_RECEPTACLE, 10, 7200) -- 2 hour
end

return entity
