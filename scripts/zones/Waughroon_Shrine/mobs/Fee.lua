-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Fe'e
-- BCNM: Up In Arms
-----------------------------------
local ID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------
---@type TMobEntity
local entity = {}

-- [Tentacles] { Phase HP%, Delay Reduction, Regain, Base Damage Multiplier, Skill ID for Auto-Attack }
local tentacleTable =
{
    [0] = { 0,  700,   0,   0, 704 },
    [1] = { 33, 700,  50, 450,   0 },
    [2] = { 44, 300, 100, 300,   0 },
    [3] = { 55, 150, 125, 250,   0 },
    [4] = { 66, 100, 150, 200,   0 },
    [5] = { 77,   0, 175, 150,   0 },
    [6] = { 88, -50, 200, 100,   0 },
}

local function setupPhase(mob, currentTentacles)
    mob:setMod(xi.mod.DELAYP, tentacleTable[currentTentacles][2])
    mob:setMod(xi.mod.REGAIN, tentacleTable[currentTentacles][3])
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, tentacleTable[currentTentacles][4])
    mob:setMobSkillAttack(tentacleTable[currentTentacles][5])
    mob:setLocalVar('currentTentacles', currentTentacles)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 35)
    setupPhase(mob, 6)
end

entity.onMobFight = function(mob, target)
    local currentTentacles = mob:getLocalVar('currentTentacles')

    -- If all our tentacles are gone, nothing to do here
    if currentTentacles <= 0 then
        return
    end

    -- Get our current HP percent and refresh tentacle count variables
    local mobHPP   = mob:getHPP()
    local phaseHPP = tentacleTable[currentTentacles][1]

    if mobHPP >= phaseHPP then
        return
    end

    -- If we lost a tentacle, update our stats and play flavor text
    setupPhase(mob, currentTentacles - 1)

    if currentTentacles - 1 == 0 then
        mob:messageText(mob, ID.text.ALL_TENTACLES_WOUNDED, false)
    else
        mob:messageText(mob, ID.text.ONE_TENTACLE_WOUNDED, false)
    end
end

return entity
