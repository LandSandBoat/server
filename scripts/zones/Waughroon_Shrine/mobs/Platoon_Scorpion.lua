-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Platoon Scorpion
-- BCNM: Operation Desert Swarm
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Waughroon_Shrine/IDs")
-----------------------------------
local entity = {}

local actionPreventingEffects =
{
    xi.effect.SLEEP_I,
    xi.effect.SLEEP_II,
    xi.effect.PETRIFICATION,
    xi.effect.STUN,
    xi.effect.CHARM_I,
    xi.effect.CHARM_II,
    xi.effect.INTIMIDATE,
    xi.effect.TERROR,
    xi.effect.LULLABY
}

local function entityCanAct(entity)
    local canAct = true

    for _, statusEffect in pairs(actionPreventingEffects) do
        if entity:hasStatusEffect(statusEffect) then
            canAct = false

            break
        end
    end

    return canAct
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("wildRagePower", 1)
    mob:setMod(xi.mod.PARALYZERES, 100)

    mob:addListener("WEAPONSKILL_STATE_EXIT", "SCORPION_MIMIC_STOP", function(mobArg, skillID)
        local battlefield = mobArg:getBattlefield():getArea()
        local mobZone     = mobArg:getZone()

        mobZone:setLocalVar(string.format("mimicControl_%s", battlefield), 0)
        mobArg:setLocalVar("mimicTimer", os.time() + 7)

        if mobZone:getLocalVar(string.format("mimicControl_%s", battlefield)) ~= 1 then
            for _, scorpionID in pairs(ID.operationDesertSwarm[battlefield]) do
                local mimic = GetMobByID(scorpionID)

                if mimic ~= nil then
                    local canAct = entityCanAct(mimic)

                    if
                        mobArg:getID() ~= scorpionID and
                        mimic:isAlive() and
                        mimic:getLocalVar("mimicTimer") < os.time() and
                        mobArg:checkDistance(mimic) < 15 and
                        canAct
                    then
                        mobZone:setLocalVar(string.format("mimicControl_%s", battlefield), 1)
                        mobArg:timer(5000, function(mimicArg)
                            mimicArg:addTP(1000)
                        end)
                    end
                end
            end
        end

        -- Scorpions are bound for 10 secounds
        if math.random() <= 0.25 and skillID == 355 then
            mobArg:showText(mob, ID.text.SCORPION_IS_STUNNED)
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

            local battlefield = mob:getBattlefield():getArea()

            for _, scorpionID in pairs(ID.operationDesertSwarm[battlefield]) do
                local scorpion = GetMobByID(scorpionID)

                if
                    scorpionID ~= mob:getID() and -- Mob isn't the same as the one that just died.
                    scorpion:isAlive()            -- Mob is still alive.
                then
                    scorpion:setLocalVar("wildRagePower", GetMobByID(scorpionID):getLocalVar("wildRagePower") + 1)
                end
            end
        end
    end
end

entity.onMobDespawn = function(mob)
    mob:removeListener("SCORPION_MIMIC_STOP")
end

return entity
