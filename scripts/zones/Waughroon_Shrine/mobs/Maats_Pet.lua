-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Maat's Pet
-- Genkai 5 Fight
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO : Change Family Type?

local petTable =
{
    {
        name = 'Rabbit',
        job = xi.job.WAR,
        modelId = 268,
        skillList =
        {
            xi.mobSkill.FOOT_KICK_1,
            xi.mobSkill.WHIRL_CLAWS_1,
            xi.mobSkill.DUST_CLOUD_1,
        },
    },

    {
        name = 'Mandragora',
        job = xi.job.MNK,
        modelId = 301,
        skillList =
        {
            xi.mobSkill.DREAM_FLOWER_1,
            xi.mobSkill.HEAD_BUTT_1,
            xi.mobSkill.LEAF_DAGGER_1,
            xi.mobSkill.PHOTOSYNTHESIS_1,
            xi.mobSkill.SCREAM_1,
            xi.mobSkill.WILD_OATS_1,
        },
    },

    {
        name = 'Tiger',
        job = xi.job.WAR,
        modelId = 308,
        skillList =
        {
            xi.mobSkill.CLAW_CYCLONE_1,
            xi.mobSkill.RAZOR_FANG_1,
            xi.mobSkill.ROAR_1,
        },
    },

    {
        name = 'Beetle',
        job = xi.job.PLD,
        modelId = 408,
        skillList =
        {
            xi.mobSkill.SPOIL_1,
            xi.mobSkill.RHINO_GUARD_1,
            xi.mobSkill.RHINO_ATTACK_1,
            xi.mobSkill.HI_FREQ_FIELD_1,
            xi.mobSkill.POWER_ATTACK_1,
        },
    },

    {
        name = 'Damselfly',
        job = xi.job.WAR,
        modelId = 448,
        skillList =
        {
            xi.mobSkill.CURSED_SPHERE_1,
            xi.mobSkill.VENOM_1,
        },
    },
}

entity.onMobSpawn = function(mob)
    xi.combat.behavior.enableAllActions(mob)

    local petChosen = math.randomInt(1, #petTable)
    local petInfo  = petTable[petChosen]

    mob:setModelId(petInfo.modelId)
    mob:changeJob(petInfo.job)
    mob:setDelay(240)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setLocalVar('petIndex', petChosen)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local petInfo = petTable[mob:getLocalVar('petIndex')]

    if not petInfo then
        return
    end

    return petInfo.skillList[math.randomInt(1, #petInfo.skillList)]
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local maat = mob:getMaster()

        if not maat then
            return
        end

        maat:setLocalVar('petSummonTime', GetSystemTime() + 30)
    end
end

return entity
