-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Hecatomb Hound
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 612, 1, xi.regime.type.GROUNDS)
end

return entity
