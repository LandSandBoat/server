-----------------------------------
-- Area: Periqia
--  Mob: Debaucher
-- Involved in Assault: Seagull Grounded
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.HPP, 40)
end

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

return entity
