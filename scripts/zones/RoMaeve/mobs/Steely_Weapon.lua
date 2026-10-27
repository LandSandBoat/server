-----------------------------------
-- Area: Ro'Maeve
--  Mob: Steely Weapon
-- Note: A Shantotto Ascension M8 fragment mob. The fragment is handled by the mission script.
-----------------------------------
require('scripts/missions/asa/helpers')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.asa.helpers.trackKillingBlow(mob)
end

return entity
