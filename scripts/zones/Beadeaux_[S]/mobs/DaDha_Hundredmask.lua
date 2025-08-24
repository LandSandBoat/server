-----------------------------------
-- Area: Beadeaux [S] (92)
--   NM: Da'Dha Hundredmask
-- !pos -89.901 .225 -159.694 92
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.BEADEAUX_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.DA_DHA_HUNDREDMASK - 100] = ID.mob.DA_DHA_HUNDREDMASK, -- -37.741 0.344 -127.037
}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 25)
    mob:addMod(xi.mod.GRAVITY_MEVA, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
