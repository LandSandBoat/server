-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl's Hound Warrior
-- Note: Pet for Xolotl
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 32)
end

return entity
