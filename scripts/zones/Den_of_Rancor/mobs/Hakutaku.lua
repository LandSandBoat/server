-----------------------------------
-- Area: Den of Rancor
--  Mob: Hakutaku
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 25)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 30)
    mob:setMod(xi.mod.SILENCERES, 99)
    mob:setMod(xi.mod.FIRE_MEVA, 800)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
