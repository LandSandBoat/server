-----------------------------------
-- Area: Caedarva Mire
--   NM: Moshdahn
-- Note: Spawned during quest: "Not Meant to Be"
-----------------------------------
mixins = { require('scripts/mixins/families/qutrub') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
