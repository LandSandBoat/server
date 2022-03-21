-----------------------------------
--  MOB: Archaic Gears
-- Area: Nyzul Isle
-----------------------------------
mixins = {require("scripts/mixins/families/gears")}
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobEngaged(mob, target)
    local instance = mob:getInstance()

    if instance:getLocalVar("gearObjective") == nyzul.gearObjective.AVOID_AGRO then
        local CE = 0
        local VE = 0
        CE = mob:getCE(target)
        VE = mob:getVE(target)

        if CE == 0 and VE == 0 and mob:getLocalVar("initialAgro") == 0 then
            mob:setLocalVar("initialAgro", 1)
            nyzul.addPenalty(mob)
        end
    end
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        local instance = mob:getInstance()

        if instance:getLocalVar("gearObjective") == nyzul.gearObjective.DO_NOT_DESTROY then
            nyzul.addPenalty(mob)
        end
    end
end
