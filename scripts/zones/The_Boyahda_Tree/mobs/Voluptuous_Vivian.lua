-----------------------------------
-- Area: The Boyahda Tree
--   NM: Voluptuous Vivian
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN_BITMASK, bit.bor(xi.drawin.NORMAL, xi.drawin.INCLUDE_ALLIANCE))
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.THE_VIVISECTOR)
end

return entity
