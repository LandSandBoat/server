-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Contemplator
-----------------------------------
mixins =
{
    require("scripts/mixins/families/empty_terroanima"),
    require("scripts/mixins/families/empty"),
}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player)
end

return entity
