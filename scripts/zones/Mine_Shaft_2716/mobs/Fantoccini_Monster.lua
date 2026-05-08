---@type TMobEntity
local entity = {}

-- TODO : Change Family Type?

local petTable =
{
    {
        name = 'Lizard',
        modelId = 328,
        skillList =
        {
            xi.mobSkill.TAIL_BLOW_1,
            xi.mobSkill.FIREBALL_1,
            xi.mobSkill.BLOCKHEAD_1,
            xi.mobSkill.BRAIN_CRUSH_1,
            xi.mobSkill.INFRASONICS_1,
            xi.mobSkill.SECRETION_1,
        },
    },

    {
        name = 'Sheep',
        modelId = 340,
        skillList =
        {
            xi.mobSkill.LAMB_CHOP_1,
            xi.mobSkill.RAGE_1,
            xi.mobSkill.SHEEP_CHARGE_1,
            xi.mobSkill.SHEEP_SONG_1,
        },
    },

    {
        name = 'Funguar',
        modelId = 376,
        skillList =
        {
            xi.mobSkill.FROGKICK_1,
            xi.mobSkill.SPORE_1,
            xi.mobSkill.QUEASYSHROOM_1,
            xi.mobSkill.NUMBSHROOM_1,
            xi.mobSkill.SHAKESHROOM_1,
            xi.mobSkill.COUNTERSPORE_1,
            xi.mobSkill.SILENCE_GAS_1,
            xi.mobSkill.DARK_SPORE_1,
        },
    },

    {
        name = 'Crab',
        modelId = 356,
        skillList =
        {
            xi.mobSkill.BUBBLE_SHOWER_1,
            xi.mobSkill.BUBBLE_CURTAIN_1,
            xi.mobSkill.BIG_SCISSORS_1,
            xi.mobSkill.SCISSOR_GUARD_1,
            xi.mobSkill.METALLIC_BODY_1,
        },
    },
}

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)

    local petChosen = math.random(1, #petTable)
    local petInfo  = petTable[petChosen]

    mob:setModelId(petInfo.modelId)
    mob:setLocalVar('petIndex', petChosen)
end

entity.onMobFight = function(mob, target)
    local petInfo = petTable[mob:getLocalVar('petIndex')]

    if not petInfo then
        return
    end

    if mob:getLocalVar('jobAbilityUsed') == 1 then
        mob:setLocalVar('jobAbilityUsed', 0)
        mob:useMobAbility(petInfo.skillList[math.random(1, #petInfo.skillList)])
    end
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
