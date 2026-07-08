-----------------------------------
-- Area: Qu'Bia Arena
-- Mob: Hell Fly
-- KSNM(30): Infernal Swarm
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
end

return entity
