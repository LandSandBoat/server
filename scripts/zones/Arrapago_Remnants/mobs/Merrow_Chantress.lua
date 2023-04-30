-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Merrow Chantress
-----------------------------------
require("scripts/globals/assault")
mixins = { require("scripts/mixins/weapon_break") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if instance:getStage() == 1 then
        xi.assault.progressInstance(mob, 1)
    end
end

return entity
