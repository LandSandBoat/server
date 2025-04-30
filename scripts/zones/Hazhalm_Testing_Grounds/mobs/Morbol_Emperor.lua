-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Morbol Emperor (Einherjar)
-- Notes: Uses Ameretat TP moves, including Vampiric Root.
-- Unverified claims:
--   - Supposedly follows a certain pattern for TP moves but captures did not show it
-----------------------------------
mixins =
{
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
end

return entity
