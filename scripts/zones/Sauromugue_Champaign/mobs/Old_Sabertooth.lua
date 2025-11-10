-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Old Sabertooth
-- Involved in Quest: The Fanged One
-- !pos 676 -10 -366 120
-----------------------------------
---@type TMobEntity
local entity = {}

local pathNodes =
{
    { x = 666.868, y = -9.506, z = -338.416, rotation = 162, wait = 10000 },
    { x = 671.028, y = -9.169, z = -345.759, rotation = 043 }, -- Turns around and runs to the next spot
    { x = 667.912, y = -9.512, z = -339.858, rotation = 172, wait = 10000 },
    { x = 661.358, y = -9.812, z = -332.499, rotation = 162, wait = 10000 },
    { x = 666.870, y = -9.506, z = -338.418, rotation = 033, wait = 10000 },
    { x = 671.745, y = -8.992, z = -347.048, rotation = 043, wait = 10000 },
    { x = 667.945, y = -9.513, z = -339.920, rotation = 172, wait = 10000 },
    { x = 662.475, y = -9.715, z = -333.734, rotation = 162 }, -- Turns around and runs to the next spot
    { x = 666.871, y = -9.506, z = -338.418, rotation = 033, wait = 10000 },
    { x = 671.712, y = -9.001, z = -346.989, rotation = 043, wait = 10000 },
    { x = 677.547, y = -10.064, z = -361.535, rotation = 075 }, -- Gateway waypoint so it doesn't path through the wall
    { x = 667.128, y = -8.359, z = -378.015, rotation = 086, wait = 100000 }, -- Final resting place
}

entity.onMobSpawn = function(mob)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.STANDBACK))
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setMobAbilityEnabled(false)
    mob:setAutoAttackEnabled(false)
    mob:addStatusEffect(xi.effect.POISON, 7, 10, 240)
    mob:addListener('TAKE_DAMAGE', 'PRIME_TAKE_DAMAGE', function(tiger, amount, attacker)
        if attacker then
            tiger:setLocalVar('tookDamage', 1)
            tiger:setMobAbilityEnabled(true)
            tiger:setAutoAttackEnabled(true)
            tiger:setBehavior(0)
        end
    end)

    mob:pathThrough(pathNodes, xi.path.flag.COORDS)
end

-- Breaks the pathing script if the mob enters the engage state
entity.onMobEngage = function(mob)
    mob:clearPath()
end

entity.onMobFight = function(mob)
    if mob:getLocalVar('control') == 0 and mob:getLocalVar('tookDamage') == 0 then
        mob:setLocalVar('control', 1)
        mob:timer(15000, function(mobArg)
            local pos = mob:getPos()
            mob:pathTo(pos.x + math.random(-2, 2), pos.y, pos.z + math.random(-2, 2), 9)
            mobArg:setLocalVar('control', 0)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)-- TODO: We currently can't move old sabertooth logic from mob script to quest script due to how the quest works
    local players = mob:getZone():getPlayers()
        for i, person in pairs(players) do -- can't use the variable name "player" because it's already being used
            if
                person:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_FANGED_ONE) == xi.questStatus.QUEST_ACCEPTED and
                person:checkDistance(mob) < 32
        then
            if mob:getLocalVar('tookDamage') == 0 then
                person:setCharVar('Quest[2][31]Timer', GetSystemTime() + 180) -- Player has about 3 minutes to get the KI before they have to watch the tiger die again.
            else
                person:setCharVar('Quest[2][31]Wait', GetSystemTime() + 300)
            end
        end
    end
end

return entity
