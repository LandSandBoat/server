-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Aw'euvhi
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
