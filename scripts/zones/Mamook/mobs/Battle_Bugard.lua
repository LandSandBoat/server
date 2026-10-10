-----------------------------------
-- Area: Mamook
--  Mob: Battle Bugard
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- Negate the family bonuses in TOAU
    mob:setMod(xi.mod.DEFP, 0)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 0)
end

return entity
