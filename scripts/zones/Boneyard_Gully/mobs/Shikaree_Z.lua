-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree Z
-----------------------------------
local entity = {}

entity.onMobEngage = function(mob, target)
    -- TODO: Need capture to see if this should actually be using 2HR ability as opposed to a direct
    -- spawn.
    local pet = SpawnMob(mob:getID() + 3)

    if pet then
        pet:updateEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
