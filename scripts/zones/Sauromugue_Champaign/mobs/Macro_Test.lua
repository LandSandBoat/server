-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Macro Test
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.macroTest.onMobSpawn(mob)
end

return entity
