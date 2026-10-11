-----------------------------------
-- Area: RoMaeve
--  Mob: Magic Flagon
-- Note: PH for Nightmare Vase and Rogue Receptacle
-- TODO: Nightmare Vase and Rogue Receptacle PHs should be in spawn groups
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 120, 1, xi.regime.type.FIELDS)
end

return entity
