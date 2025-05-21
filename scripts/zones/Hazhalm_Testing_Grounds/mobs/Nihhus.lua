-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Nihhus (Einherjar)
-- Notes: Standard Wivre moves + Crippling Slam
-- Unverified/unimplemented claims:
--  - Crippling Slam is only used under 30%
--  - Batterhorn seems to reset hate.
--  - Magic damage is reduced by 35%
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
