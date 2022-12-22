-----------------------------------
-- Area: Sauromugue Champaign (120)
--  HNM: Roc
-----------------------------------
mixins =
{
    require("scripts/mixins/rage"),
    require("scripts/mixins/job_special"),
}
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMod(xi.mod.EVA, 300)
    -- custom distance from retail capture
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 34)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.ROC_STAR)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
