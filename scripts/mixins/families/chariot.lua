require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.chariot = function(mob)
    mob:addListener("SPAWN", "CHARIOT_SPAWN", function(mob)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    end)

    mob:addListener("ENGAGE", "CHARIOT_ENGAGE", function(mob)
        mob:setLocalVar("turnTime", os.time())
        mob:setLocalVar("turnDelay", math.random(10, 30))
    end)

    mob:addListener("COMBAT_TICK", "CHARIOT_COMBAT", function(mob)
        local time = os.time()

        if time >= mob:getLocalVar("turnTime") then
            mob:face()
            mob:setLocalVar("turnTime", time + math.random(10, 30))
        end
    end)
end

return g_mixins.families.chariot
