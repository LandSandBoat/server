-----------------------------------
-- Area: Manaclipper
--   NM: Harajnite
-----------------------------------
mixins = { require('scripts/mixins/families/uragnite') }
-----------------------------------
local entity = {}

entity.onMobEngage = function(mob, player)
    mob:setLocalVar('[uragnite]inShellRegen', 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
