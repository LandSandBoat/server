-----------------------------------
-- Area: Periqia (Requiem)
--  Mob: Draugars Wyvern
-----------------------------------
mixins = {require("scripts/mixins/pet_instanced")}
require("scripts/globals/status")
require("scripts/globals/assault")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    assaultUtil.adjustMobLevel(mob, mob:getID())
    mob:addImmunity(xi.immunity.SLEEP)
end

entity.onMobDeath = function(mob, player, isKiller, firstCall)
end

return entity
