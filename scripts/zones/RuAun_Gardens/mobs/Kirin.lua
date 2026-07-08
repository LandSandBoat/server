-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Kirin
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.events.strangeHappenings.onMobInitialize(mob)

    if xi.settings.main.ENABLE_STRANGE_HAPPENINGS ~= 1 then
        DisallowRespawn(mob:getID(), true)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.events.strangeHappenings.onMobDeath(mob)
end

return entity
