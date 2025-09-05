-----------------------------------
-- Area: Quicksand Caves
--   NM: Centurio X-I
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  754.000, y =  2.000, z = -553.000 },
    { x =  765.000, y =  1.000, z = -572.000 },
    { x =  781.000, y =  2.000, z = -556.000 },
    { x =  798.000, y =  2.000, z = -567.000 },
    { x =  804.000, y =  2.000, z = -552.000 }
}

entity.phList =
{
    [ID.mob.CENTURIO_X_I - 1] = ID.mob.CENTURIO_X_I, -- 773.581 1.576 -568.904
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.GIL_MIN, 2000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 630)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.SILENCE_MEVA, 35)
    mob:addMod(xi.mod.SLEEP_MEVA, 50)
    mob:addMod(xi.mod.LULLABY_MEVA, 50)
    mob:addMod(xi.mod.SPELLINTERRUPT, 25)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 426)
end

return entity
