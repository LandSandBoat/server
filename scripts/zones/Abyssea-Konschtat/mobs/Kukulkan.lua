-----------------------------------
-- Area: Abyssea - Konschtat (15)
--   NM: Kukulkan
-----------------------------------
mixins = { require('scripts/mixins/families/peiste') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.KUKULKAN_DEFANGER)
end

return entity
