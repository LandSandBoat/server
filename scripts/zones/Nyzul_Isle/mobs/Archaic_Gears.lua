-----------------------------------
--  MOB: Archaic Gears
-- Area: Nyzul Isle
-----------------------------------
mixins = {require("scripts/mixins/families/gears")}
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/utils/nyzul")
-----------------------------------
local entity = {}

entity.onMobEngaged= function(mob, target)
    local instance = mob:getInstance()

    if instance:getLocalVar("gearObjective") == xi.nyzul.gearObjective.AVOID_AGRO then
        local CE = 0
        local VE = 0
        CE = mob:getCE(target)
        VE = mob:getVE(target)

        if CE == 0 and VE == 0 and mob:getLocalVar("initialAgro") == 0 then
            mob:setLocalVar("initialAgro", 1)
            xi.nyzul.addPenalty(mob)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        local instance = mob:getInstance()

        if instance:getLocalVar("gearObjective") == xi.nyzul.gearObjective.DO_NOT_DESTROY then
            xi.nyzul.addPenalty(mob)
        end
    end
end

return entity
