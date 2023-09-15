-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Aw'euvhi
-----------------------------------
mixins = { require("scripts/mixins/families/euvhi") }
-----------------------------------
local entity = {}

entity.onMobDisengage = function(mob)
    mob:setAnimationSub(0)
end

return entity
