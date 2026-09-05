-----------------------------------
-- Area: Periqia
--  Mob: Arrapago Crab
-- Involved in Assault: Seagull Grounded
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

return entity
