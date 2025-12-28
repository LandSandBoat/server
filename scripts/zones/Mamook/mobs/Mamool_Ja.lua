-----------------------------------
--  Area: Mamook
--    NM: Mamool Ja
-- Quest: Two Horn the Savage
-- !zone 65
-- Viscous Liquid !pos -262.437 5.130 -141.241
-- TODO: The NM is supposed to look at its active target when cycling between nodes.
-----------------------------------
mixins =
{
    require('scripts/mixins/weapon_break')
}
-----------------------------------
---@type TMobEntity
local entity = {}

local paths =
{
    HEAL1 = 1,
    HEAL2 = 2,
    HEAL3 = 3,
    HEAL4 = 4,
    HEAL5 = 5,
    HEAL6 = 6,
    HEAL7 = 7,
    HEAL8 = 8,
    SPAWN = 9,
}

local pathNodes =
{
    [paths.HEAL1] =
    {
        { x = -264.018, y = 004.920, z = -145.779 },
    },
    [paths.HEAL2] =
    {
        { x = -256.346, y = 005.062, z = -137.394 },
    },
    [paths.HEAL3] =
    {
        { x = -255.644, y = 004.907, z = -144.149 },
    },
    [paths.HEAL4] =
    {
        { x = -252.875, y = 005.091, z = -140.162 },
    },
    [paths.HEAL5] =
    {
        { x = -260.354, y = 004.878, z = -136.609 },
    },
    [paths.HEAL6] =
    {
        { x = -260.038, y = 004.989, z = -145.486 },
    },
    [paths.HEAL7] =
    {
        { x = -263.814, y = 005.118, z = -137.361 },
    },
    [paths.HEAL8] =
    {
        { x = -267.267, y = 005.109, z = -142.522 },
    },
    [paths.SPAWN] =
    {
        -- From spawn to the staging spot before it engages
        { x = -257.529, y = 4.627, z = -149.291 },
        { x = -252.861, y = 5.091, z = -140.169 }, -- Ending Spot
    },
}

-- Determines the next spot where the NM will stand. It is intended for the NM to cycle between two spots and pace while its regen is active.
local findHealNode = function(mob, target)
    local largestDist = 0.0
    local nextNode    = 0
    local spawnPos    = mob:getSpawnPos()

    if mob:checkDistance(pathNodes[paths.SPAWN][1].x, pathNodes[paths.SPAWN][1].y, pathNodes[paths.SPAWN][1].z) <= 20 then
        for idx = 1, 8, 1 do
            local currentNode = pathNodes[idx][1]
            local playerDist  = target:checkDistance(currentNode.x, currentNode.y, currentNode.z)
            if
                playerDist > largestDist and
                mob:checkDistance(currentNode.x, currentNode.y, currentNode.z) > 1.0
            then
                largestDist = playerDist
                nextNode    = idx
            end
        end

    else
        nextNode = paths.SPAWN
        mob:setLocalVar('checkedDist', mob:checkDistance(spawnPos.x, spawnPos.y, spawnPos.z))
    end

    mob:setLocalVar('healNode', nextNode)
    mob:pathTo(pathNodes[nextNode][1].x, pathNodes[nextNode][1].y, pathNodes[nextNode][1].z, bit.bor(xi.path.flag.SCRIPT, xi.path.flag.RUN))
end

local doHealing = function(mob)
    mob:setLocalVar('isHealing', 1)
    mob:setAutoAttackEnabled(false) -- Stops the NM from attacking until it is fully re-engaged with the player
    mob:addStatusEffectEx(xi.effect.BIND, xi.effect.BIND, 0, 0, 5, 0, 0, 0, xi.effectFlag.NO_LOSS_MESSAGE, true) -- Will bind the NM to stop it from moving for a set time.
    if
        mob:getHPP() < 85 and
        not mob:hasStatusEffect(xi.effect.REGEN)
    then
        mob:addStatusEffectEx(xi.effect.REGEN, xi.effect.REGEN, 264, 5, 100, 0, 0, xi.effectFlag.NO_LOSS_MESSAGE, true)
    end
end

local spawnDance = function(mob)
    mob:pathTo(pathNodes[paths.SPAWN][1].x, pathNodes[paths.SPAWN][1].y, pathNodes[paths.SPAWN][1].z, xi.path.flag.SCRIPT)
    mob:pathTo(pathNodes[paths.SPAWN][2].x, pathNodes[paths.SPAWN][2].y, pathNodes[paths.SPAWN][2].z, xi.path.flag.SCRIPT)

    if mob:checkDistance(pathNodes[paths.SPAWN][2].x, pathNodes[paths.SPAWN][2].y, pathNodes[paths.SPAWN][2].z) < 1 then
        mob:addStatusEffectEx(xi.effect.BIND, xi.effect.BIND, 0, 0, 5, 0, 0, 0, xi.effectFlag.NO_LOSS_MESSAGE, true)
        mob:setLocalVar('justSpawned', 0)
    end
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setLocalVar('justSpawned', 1)
end

entity.onMobMobskillChoose = function(mob, target)
    if mob:getAnimationSub() >= 1 then
        return xi.mobSkill.FORCEFUL_BLOW -- Will ONLY use Forceful Blow when it's weapon is broken.
    end
end

entity.onMobFight = function(mob, target)
    local healNode    = mob:getLocalVar('healNode')
    local spawnPos    = mob:getSpawnPos() -- Checks the NM's spawn POS
    local checkedDist = mob:getLocalVar('checkedDist') -- Updates when the NM uses a TP move or when it heals more than 30 yalms away from spawn
    local targetDist  = mob:checkDistance(target) -- Used to check the NM's disance from it's current Target
    local spawnDist   = mob:checkDistance(spawnPos.x, spawnPos.y, spawnPos.z)
    local isHealing   = mob:getLocalVar('isHealing')
    local justSpawned = mob:getLocalVar('justSpawned')
    local hpp         = mob:getHPP()

    -- When the NM is spawned it will run to a set spot before engaging the player.
    if justSpawned == 1 then
        spawnDance(mob)
    end

    -- When the NM is taken down to 75% or less it has a high chance of being intimidated
    if
        hpp <= 75 and
        not mob:hasStatusEffect(xi.effect.INTIMIDATE)
    then
        mob:addStatusEffectEx(xi.effect.INTIMIDATE, xi.effect.NONE, 20, 0, 0xFFFF, 0, 0, 0, xi.effectFlag.NO_LOSS_MESSAGE, true)
    elseif hpp > 75 then
        mob:delStatusEffect(xi.effect.INTIMIDATE)
    end

    -- If the player enters melee range then the NM will re-engage and stop healing
    -- The NM will re-engage on its own if it heals over 85% of its health
    if
        isHealing == 1 and
        (hpp >= 85 or targetDist <= 5)
    then
        mob:delStatusEffectSilent(xi.effect.REGEN)
        mob:setAutoAttackEnabled(true)
        mob:clearPath()
        mob:setLocalVar('healNode', 0)
        mob:setLocalVar('isHealing', 0)
    end

    -- Determines how the NM will heal.
    -- If 20 yalms or more away from spawn the NM will travel back towards spawn stopping to heal along the way.
    -- If within 20 yalms of spawn it will cycle perform normal healing mechanics
    if healNode ~= 0 then
        if spawnDist <= 20 then
            if mob:checkDistance(pathNodes[healNode][1]) < 1 then
                doHealing(mob)
                findHealNode(mob, target)
            end
        elseif spawnDist > 20 then
            if checkedDist - spawnDist >= 10 then -- Checks if the NM has moved 10 yalms or more from the last time it healed.
                doHealing(mob)
                mob:setLocalVar('checkedDist', spawnDist)
            end
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    findHealNode(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
