-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Gorgimera (Einherjar)
-- Notes: Khimaira regular moves. No known special mechanics.
-----------------------------------
mixins =
{
    require('scripts/mixins/families/khimaira'),
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
end

return entity
