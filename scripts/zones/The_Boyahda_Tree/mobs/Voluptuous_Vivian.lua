-----------------------------------
-- Area: The Boyahda Tree
--   NM: Voluptuous Vivian
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 2)
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.THE_VIVISECTOR)
end

return entity
