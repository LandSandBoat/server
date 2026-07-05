-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Fe'e
-- BCNM: Up In Arms
-----------------------------------
local ID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------
---@type TMobEntity
local entity = {}

-- [Tentacles] { Phase HP%, Delay, Regain, Base Damage Multiplier, Skill ID for Auto-Attack }
local tentacleTable =
{
    [0] = { 0,  600,   0,   0, 704 },
    [1] = { 33, 700,  50, 450,   0 },
    [2] = { 44, 560, 100, 300,   0 },
    [3] = { 55, 360, 125, 250,   0 },
    [4] = { 66, 280, 150, 200,   0 },
    [5] = { 77, 140, 175, 150,   0 },
    [6] = { 88,  70, 200, 100,   0 },
}

local function setupPhase(mob, currentTentacles)
    mob:setDelay(tentacleTable[currentTentacles][2])
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

entity.onMobMobskillChoose = function(mob, target, skillId)
    if skillId == xi.mobSkill.INK_JET_ATTACK then
        return 0
    end

    local skillList = {}

    if mob:checkDistance(target) >= 12 then
        table.insert(skillList, xi.mobSkill.HARD_MEMBRANE_1)
        table.insert(skillList, xi.mobSkill.REGENERATION_1)
    end

    if mob:getLocalVar('currentTentacles') == 0 then
        table.insert(skillList, xi.mobSkill.MAELSTROM_1)
    else
        table.insert(skillList, xi.mobSkill.INK_JET_1)
    end

    return skillList[math.randomInt(1, #skillList)]
end

return entity
