-- To Do: Venom Shell poison tick rate is 26/HP per tick based on retail captures.
-- To Do: Can be fished up multiple times in a row seemingly without any cooldown based on retail captures. The chance to hook this NM is very high.
-- Note: Can be fished up with any combination of fishing skill and rod/bait based on retail captures.
-- To Do: Fix uragnite family mixin. Right now, they do not go into their shells to heal.
-----------------------------------
-- Area: Manaclipper
--   NM: Cyclopean Conch
-----------------------------------
mixins = { require('scripts/mixins/families/uragnite') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobEngage = function(mob, player)
    mob:setLocalVar('[uragnite]inShellRegen', 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
