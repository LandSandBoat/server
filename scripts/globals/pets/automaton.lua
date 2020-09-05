-----------------------------------
-- PET: Automaton
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/pets")

function onMobSpawn(mob)
    mob:setLocalVar("MANEUVER_DURATION", 60)
    mob:addListener("EFFECTS_TICK", "MANEUVER_DURATION", function(automaton)
        if (automaton:getTarget()) then
            local dur = automaton:getLocalVar("MANEUVER_DURATION")
            automaton:setLocalVar("MANEUVER_DURATION", math.min(dur+3, 300))
        end
    end)
end

function onMobDeath(mob)
    mob:removeListener("MANEUVER_DURATION")
end
