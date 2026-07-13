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
    { x = 653.744, y =  -9.640, z = -328.601, rotation = 146, wait =  50000 }, -- Starting position
    { x = 659.830, y = -10.235, z = -331.406, rotation = 017, wait =  12000 },
    { x = 666.793, y = -10.053, z = -338.386, rotation = 032, wait =  19000 },
    { x = 671.675, y =  -9.494, z = -346.934, rotation = 042, wait =  17000 },
    { x = 667.914, y =  -9.982, z = -339.863, rotation = 172, wait =  38000 },
    { x = 661.361, y = -10.305, z = -332.502, rotation = 162, wait =  13000 },
    { x = 675.301, y = -10.208, z = -356.221, rotation = 063                }, -- Pathing node to avoid wall.
    { x = 677.547, y = -10.064, z = -361.535, rotation = 075                }, -- Pathing node to avoid wall.
    { x = 667.100, y =  -9.474, z = -378.066, rotation = 086, wait = 100000 }, -- Resting place.
}

entity.onMobInitialize = function(mob)
    mob:addListener('TAKE_DAMAGE', 'PRIME_TAKE_DAMAGE', function(mobArg, amount, attacker)
        if not attacker then
            return
        end

        mobArg:setLocalVar('tookDamage', 1)
        mobArg:setMobAbilityEnabled(true)
        mobArg:setAutoAttackEnabled(true)
        mobArg:setBehavior(0)
    end)
end

entity.onMobSpawn = function(mob)
    -- Handle behavior.
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.STANDBACK))
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setMobAbilityEnabled(false)
    mob:setAutoAttackEnabled(false)

    -- Handle poison.
    local poisonPower    = math.floor(mob:getHP() / 64) -- Kill Old Sabertooth 3.5 minutes with 3-second ticks.
    local poisonDuration = 1800                         -- Ensure it doesn't wear off before it dies.
    mob:addStatusEffect(xi.effect.POISON, { power = poisonPower, duration = poisonDuration, origin = mob })

    -- Handle path.
    mob:pathThrough(pathNodes, xi.path.flag.COORDS)
end

-- Breaks the pathing script if the mob enters the engage state
entity.onMobEngage = function(mob)
    mob:clearPath()
end

entity.onMobFight = function(mob)
    if mob:getLocalVar('tookDamage') ~= 0 then
        return
    end

    if mob:getLocalVar('control') ~= 0 then
        return
    end

    mob:setLocalVar('control', 1)
    mob:timer(15000, function(mobArg)
        local pos = mob:getPos()
        mob:pathTo(pos.x + math.randomInt(-2, 2), pos.y, pos.z + math.randomInt(-2, 2), 9)
        mobArg:setLocalVar('control', 0)
    end)
end

-- TODO: We currently can't move old sabertooth logic from mob script to quest script due to how the quest works.
entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local players       = mob:getZone():getPlayers()
        local diedNaturally = mob:getLocalVar('tookDamage') == 0 and true or false

        for i, person in pairs(players) do
            if
                person:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_FANGED_ONE) == xi.questStatus.QUEST_ACCEPTED and
                person:checkDistance(mob) < 32
            then
                if diedNaturally then
                    person:setCharVar('Quest[2][31]Timer', GetSystemTime() + 180) -- Player has about 3 minutes to get the KI before they have to watch the tiger die again.
                else
                    person:setCharVar('Quest[2][31]Wait', GetSystemTime() + 300)
                end
            end
        end
    end
end

return entity
