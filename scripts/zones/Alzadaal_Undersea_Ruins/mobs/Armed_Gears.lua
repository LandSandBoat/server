-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  Mob: Armed Gears
-- !pos -19 -4 -153
-----------------------------------
-- todo
-- add add random elemental magic absorb to elements its casting
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/families/gears")
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.MDEF, 60)
    mob:addMod(xi.mod.DEF, 60)
    mob:setAnimationSub(0)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
