-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Maat
-- Genkai 5 Fight
-----------------------------------
mixins = { require('scripts/mixins/families/maat') }
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local mobId = mob:getID()
    local pet   = GetMobByID(mobId + 1)

    if
        pet and
        pet:isSpawned() and
        pet:getCurrentAction() == xi.act.ROAMING
    then
        pet:updateEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
