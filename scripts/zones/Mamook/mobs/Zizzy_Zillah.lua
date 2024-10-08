-----------------------------------
-- Area: Mamook
--   NM: Zizzy Zillah
-----------------------------------
mixins = { require('scripts/mixins/families/ziz') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 460)
end

return entity
