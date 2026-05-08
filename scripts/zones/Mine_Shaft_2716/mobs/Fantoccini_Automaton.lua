---@type TMobEntity
local entity = {}

local petTable =
{
    {
        name = 'Melee Automaton',
        modelId = 1983,
        job = xi.job.PLD,
        skillList =
        {
            xi.mobSkill.CHIMERA_RIPPER,
            xi.mobSkill.STRING_CLIPPER,
        },
    },

    {
        name = 'Ranged Automaton',
        modelId = 1990,
        job = xi.job.RNG,
        skillList =
        {
            xi.mobSkill.ARCUBALLISTA,
            xi.mobSkill.DAZE,
        },
    },

    {
        name = 'Magic Automaton',
        modelId = 1994,
        job = xi.job.RDM,
        skillList =
        {
            xi.mobSkill.SLAPSTICK,
            xi.mobSkill.KNOCKOUT,
        },
    },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 27)
end

entity.onMobSpawn = function(mob)
    local petChosen = math.random(1, #petTable)
    local petInfo  = petTable[petChosen]

    mob:setModelId(petInfo.modelId)

    if petInfo.job == xi.job.PLD then
        mob:setMobMod(xi.mobMod.CAN_SHIELD_BLOCK, 1)
    else
        mob:setMobMod(xi.mobMod.CAN_SHIELD_BLOCK, 0)
    end

    if petInfo.job == xi.job.RNG then
        mob:setRangedAttackEnabled(true)
        mob:setMobMod(xi.mobMod.RANGED_ATTACK_RANGE, 14)
    else
        mob:setRangedAttackEnabled(false)
    end

    if petInfo.job == xi.job.RDM then
        mob:setMagicCastingEnabled(true)
    else
        mob:setMagicCastingEnabled(false)
    end

    mob:setLocalVar('petIndex', petChosen)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local petInfo = petTable[mob:getLocalVar('petIndex')]

    if not petInfo then
        return 0
    end

    return petInfo.skillList[math.random(1, #petInfo.skillList)]
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local fantoccini = mob:getMaster()

        if not fantoccini then
            return
        end

        fantoccini:setLocalVar('petSummonTime', GetSystemTime() + 45)
    end
end

return entity
