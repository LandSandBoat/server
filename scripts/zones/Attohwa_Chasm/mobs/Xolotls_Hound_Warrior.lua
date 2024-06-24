-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl's Hound Warrior
-- Note: Pet for Xolotl
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 32)
end

return entity
