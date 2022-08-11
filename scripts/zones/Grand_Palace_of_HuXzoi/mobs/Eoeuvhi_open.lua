-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  Mob: Eo'euvhi
-----------------------------------
mixins = {require("scripts/mixins/families/euvhi")}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(2)
end

entity.onMobDisengage = function(mob)
    mob:setAnimationSub(2)
end

return entity
