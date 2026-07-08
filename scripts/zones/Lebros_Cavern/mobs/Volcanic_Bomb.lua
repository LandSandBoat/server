-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Volcanic Bomb
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

return entity
