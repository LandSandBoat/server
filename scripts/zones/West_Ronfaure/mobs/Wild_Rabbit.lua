-----------------------------------
-- Area: West Ronfaure
--  Mob: Wild Rabbit
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.EXP_LVL_MOD, -2) -- Subtract 2 levels for /check and exp purposes
end

return entity
