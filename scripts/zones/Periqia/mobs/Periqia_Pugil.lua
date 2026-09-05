-----------------------------------
-- Area: Periqia
--  Mob: Periqia Pugil
-- Involved in Assault: Seagull Grounded
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

return entity
