-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Platoon Scorpion
-- BCNM: Operation Desert Swarm
-----------------------------------
local ID = require("scripts/zones/Waughroon_Shrine/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("wildRagePower", 1)
    mob:setMod(xi.mod.SLEEPRESBUILD, 30)

    mob:addListener("WEAPONSKILL_STATE_EXIT", "SCORPION_MIMIC_STOP", function(mobArg, skillID)
        local bf = mobArg:getBattlefield():getArea()
        mobArg:getZone():setLocalVar(string.format("mimicControl_%s", bf), 0)
        mob:setLocalVar("mimicTimer", os.time() + 7)

        if mobArg:getZone():getLocalVar(string.format("mimicControl_%s", bf)) ~= 1 then
            for _, allyID in pairs(ID.operationDesertSwarm[bf]) do
                local mimic = GetMobByID(allyID)

                if
                    mobArg:getID() ~= allyID and
                    mimic:isAlive() and mimic ~= nil and
                    mimic:getLocalVar("mimicTimer") < os.time() and
                    mobArg:checkDistance(mimic) < 15 and
                    not (mimic:hasStatusEffect(xi.effect.SLEEP_I) or
                    mimic:hasStatusEffect(xi.effect.SLEEP_II))
                then
                    mobArg:getZone():setLocalVar(string.format("mimicControl_%s", bf), 1)
                    mobArg:timer(5000, function(mimicArg)
                        mimicArg:addTP(1000)
                    end)
                end
            end
        end

        -- Scorpions are bound for 10 secounds
        if math.random() <= 0.25 and skillID == 355 then
            mobArg:showText(mob, ID.text.SCORPION_IS_BOUND)
            mobArg:addStatusEffect(xi.effect.BIND, 1, 0, 10)

        -- Scorpions can still move around, but will not auto attack
        elseif math.random() <= 0.25 and skillID == 354 then
            mobArg:showText(mob, ID.text.SCORPION_NO_ENERGY)
            mobArg:setAutoAttackEnabled(false)
            mobArg:timer(1000 * math.random(25, 30), function(mobArg1)
                mobArg1:setAutoAttackEnabled(true)
            end)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        if mob:getLocalVar("deathControl") == 0 then
            mob:setLocalVar("deathControl", 1)
            local bf = mob:getBattlefield():getArea()

            for _, allyID in pairs(ID.operationDesertSwarm[bf]) do
                local scorpion = GetMobByID(allyID)

                if allyID ~= mob:getID() and scorpion:isAlive() then
                    scorpion:setLocalVar("wildRagePower", GetMobByID(allyID):getLocalVar("wildRagePower") + 1)
                    scorpion:addMod(xi.mod.SLEEPRESBUILD, 200)
                    scorpion:addMod(xi.mod.LULLABYRESBUILD, 200)
                end
            end
        end
    end
end

entity.onMobDespawn = function(mob)
    mob:removeListener("SCORPION_MIMIC_START")
    mob:removeListener("SCORPION_MIMIC_STOP")
end

return entity
