-----------------------------------
-- Area: Dragons Aery
--  Mob: Darter
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALLI_HATE, 30) -- 30 yalm distance
end

return entity
