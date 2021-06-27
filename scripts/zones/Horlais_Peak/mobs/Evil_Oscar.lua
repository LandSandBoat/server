-----------------------------------
-- Area: Horlais Peak
--  Mob: Evil Oscar
-- KSNM30
-----------------------------------
local ID = require("scripts/zones/Horlais_Peak/IDs")
-----------------------------------
local entity = {}

local EXTREMELY_BAD_BREATH = 1332

local evilOscarFillsHisLungs
evilOscarFillsHisLungs = function(mob)
    local ebbBreathCounter = mob:getLocalVar("EBB_BREATH_COUNTER")
    if ebbBreathCounter >= 3 then
        mob:setLocalVar("EBB_BREATH_COUNTER", 0)
        mob:useMobAbility(EXTREMELY_BAD_BREATH)
    else
         mob:setLocalVar("EBB_BREATH_COUNTER", ebbBreathCounter + 1)

        local battlefield = mob:getBattlefield()
        local players = battlefield:getPlayers()

        local someoneIsAlive = false
        for _, member in pairs(players) do
            if member:isAlive() then
                someoneIsAlive = true
            end
        end

        if someoneIsAlive then
            for _, member in pairs(players) do
                member:messageSpecial(ID.text.EVIL_OSCAR_BEGINS_FILLING)
            end
        end
    end

    mob:timer(10000 + math.random(5000), evilOscarFillsHisLungs)
end

entity.onMobInitialize = function(mob)
    -- Melee attacks have Additional effect: Weight.
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.WEIGHT)
end

entity.onMobSpawn = function(mob)
end

entity.onMobEngaged = function(mob, target)
    mob:timer(10000 + math.random(5000), evilOscarFillsHisLungs)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
