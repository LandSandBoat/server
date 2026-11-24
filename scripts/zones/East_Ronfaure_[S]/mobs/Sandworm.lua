-----------------------------------
-- Area: East Ronfaure [S]
--  Mob: Sandworm
-- Note: Title Given if Sandworm does not Doomvoid
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.sandworm.onMobInitialize(mob)
end

return entity
