-----------------------------------
--  MOB: Archaic Gears
-- Area: Nyzul Isle
-----------------------------------
mixins = { require('scripts/mixins/families/gears') }
require('scripts/globals/nyzul')
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    local instance = mob:getInstance()

    if instance:getLocalVar("gearObjective") == xi.nyzul.gearObjective.AVOID_AGRO then
        local ce = mob:getCE(target)
        local ve = mob:getVE(target)

        if ce == 0 and ve == 0 and mob:getLocalVar("initialAgro") == 0 then
            mob:setLocalVar("initialAgro", 1)
            xi.nyzul.addPenalty(mob)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance:getLocalVar("gearObjective") == xi.nyzul.gearObjective.DO_NOT_DESTROY then
            xi.nyzul.addPenalty(mob)
        end
    end
end

return entity
