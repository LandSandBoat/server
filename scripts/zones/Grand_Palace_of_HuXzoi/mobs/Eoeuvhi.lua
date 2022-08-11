-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  Mob: Eo'euvhi
-----------------------------------
mixins = {require("scripts/mixins/families/euvhi")}
-----------------------------------
local entity = {}

entity.onMobDisengage = function(mob)
    mob:setAnimationSub(0)
end

return entity
