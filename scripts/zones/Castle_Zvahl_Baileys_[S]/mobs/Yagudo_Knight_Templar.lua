-----------------------------------
-- Area: Castle Zvahl Baileys [S]
--  Mob: Yagudo Knight Templar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
end

return entity
