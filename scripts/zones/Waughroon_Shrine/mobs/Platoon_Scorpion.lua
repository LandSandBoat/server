-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Platoon Scorpion
-- BCNM: Operation Desert Swarm
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Waughroon_Shrine/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("wildRagePower", 1)

    mob:addListener("WEAPONSKILL_STATE_ENTER", "SCORPION_MIMIC_START", function(mobArg, skillID)
        local bf = mobArg:getBattlefield():getArea()

        if mobArg:getZone():getLocalVar(string.format("mimicControl_%s",bf)) ~= 1 then
            for _, allyID in pairs(ID.operationDesertSwarm[bf]) do
                local mimic = GetMobByID(allyID)
                local dist = mobArg:checkDistance(mimic)

                if
                    mobArg:getID() ~= allyID and
                    mimic:isAlive() and mimic ~= nil and
                    mimic:getLocalVar("mimicTimer") < os.time() and
                    dist < 15
                then
                    mobArg:getZone():setLocalVar(string.format("mimicControl_%s",bf), 1)
                    mimic:useMobAbility(skillID)
                elseif mimic:getLocalVar("mimicTimer") > os.time() then
                    mob:showText(mob,ID.text.SCORPION_NO_ENERGY)
                end
            end
        end
    end)

    mob:addListener("WEAPONSKILL_STATE_EXIT", "SCORPION_MIMIC_STOP", function(mobArg, skillID)
        local bf = mobArg:getBattlefield():getArea()
        mobArg:getZone():setLocalVar(string.format("mimicControl_%s",bf), 0)
        mob:setLocalVar("mimicTimer", os.time() + 7)

        if math.random() <= 0.25 then
            mobArg:showText(mob,ID.text.SCORPION_IS_BOUND)
            mobArg:addStatusEffect(xi.effect.BIND,1,0,10)
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
    if isKiller then
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
