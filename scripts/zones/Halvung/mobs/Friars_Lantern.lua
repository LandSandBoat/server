-----------------------------------
-- Area: Halvung
--  Mob: Friar's Lantern
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- Non NM TOAU Single Bombs do not gain 1.5x damage
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 0)
end

return entity
