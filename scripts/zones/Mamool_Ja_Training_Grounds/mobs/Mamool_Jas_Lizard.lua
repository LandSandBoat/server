-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  Mob: Mamool Ja Lizard
-----------------------------------
mixins = {require("scripts/mixins/pet_instanced")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    assaultUtil.adjustMobLevel(mob, mob:getID())
    mob:setLocalVar("masterID", mob:getID() -1)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
