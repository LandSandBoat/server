-----------------------------------
-- Area: The Ashu Talif (The Black Coffin)
--  Mob: Ashu Talif Crew (MNK)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobDeath = function(mob, player, optParams)
    local instance = mob:getInstance()
    if
        instance and
        (optParams.isKiller or optParams.noKiller)
    then
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
