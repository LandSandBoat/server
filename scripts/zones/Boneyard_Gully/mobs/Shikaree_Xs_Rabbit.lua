-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree X's Rabbit
-----------------------------------
---@type TMobEntity
local entity = {}

-----------------------------------
-- Sets initial mob-specific immunities.
-----------------------------------
entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobDespawn = function(mob)
    local master = GetMobByID(mob:getID() - 2)
    if master then
        master:setLocalVar('petTimer', GetSystemTime() + 15)
    end
end

return entity
