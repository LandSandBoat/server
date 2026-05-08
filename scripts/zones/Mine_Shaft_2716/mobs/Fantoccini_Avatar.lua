---@type TMobEntity
local entity = {}

-- TODO : Change Family Type?

local avatarTable =
{
    {
        name      = 'Carbuncle',
        modelId   = 791,
        skillList =
        {
            xi.mobSkill.HEALING_RUBY,
            xi.mobSkill.POISON_NAILS,
            xi.mobSkill.SHINING_RUBY,
            xi.mobSkill.GLITTERING_RUBY,
            xi.mobSkill.METEORITE,
        },
        twoHour   = xi.mobSkill.SEARING_LIGHT_1,
    },

    {
        name      = 'Fenrir',
        modelId   = 792,
        skillList =
        {
            xi.mobSkill.MOONLIT_CHARGE,
            xi.mobSkill.CRESCENT_FANG,
            xi.mobSkill.LUNAR_CRY,
            xi.mobSkill.LUNAR_ROAR,
            xi.mobSkill.ECLIPTIC_GROWL,
            xi.mobSkill.ECLIPTIC_HOWL,
        },
        twoHour   = xi.mobSkill.HOWLING_MOON_2,
    },

    {
        name      = 'Ifrit',
        modelId   = 793,
        skillList =
        {
            xi.mobSkill.PUNCH,
            xi.mobSkill.FIRE_II,
            xi.mobSkill.BURNING_STRIKE,
            xi.mobSkill.DOUBLE_PUNCH,
            xi.mobSkill.CRIMSON_HOWL,
            xi.mobSkill.FIRE_IV,
        },
        twoHour   = xi.mobSkill.INFERNO_1,
    },

    {
        name      = 'Titan',
        modelId   = 794,
        skillList =
        {
            xi.mobSkill.ROCK_THROW,
            xi.mobSkill.STONE_II,
            xi.mobSkill.ROCK_BUSTER,
            xi.mobSkill.MEGALITH_THROW,
            xi.mobSkill.EARTHEN_WARD,
            xi.mobSkill.STONE_IV,
        },
        twoHour   = xi.mobSkill.EARTHEN_FURY_1,
    },

    {
        name      = 'Leviathan',
        modelId   = 795,
        skillList =
        {
            xi.mobSkill.BARRACUDA_DIVE,
            xi.mobSkill.WATER_II,
            xi.mobSkill.TAIL_WHIP,
            xi.mobSkill.SLOWGA,
            xi.mobSkill.SPRING_WATER,
            xi.mobSkill.WATER_IV,
        },
        twoHour   = xi.mobSkill.TIDAL_WAVE_1,
    },

    {
        name      = 'Garuda',
        modelId   = 796,
        skillList =
        {
            xi.mobSkill.CLAW,
            xi.mobSkill.AERO_II,
            xi.mobSkill.AERIAL_ARMOR,
            xi.mobSkill.WHISPERING_WIND,
            xi.mobSkill.HASTEGA,
            xi.mobSkill.AERO_IV,
        },
        twoHour   = xi.mobSkill.AERIAL_BLAST_1,
    },

    {
        name      = 'Shiva',
        modelId   = 797,
        skillList =
        {
            xi.mobSkill.AXE_KICK,
            xi.mobSkill.BLIZZARD_II,
            xi.mobSkill.FROST_ARMOR,
            xi.mobSkill.SLEEPGA,
            xi.mobSkill.DOUBLE_SLAP,
            xi.mobSkill.BLIZZARD_IV,
        },
        twoHour   = xi.mobSkill.DIAMOND_DUST_1,
    },

    {
        name      = 'Ramuh',
        modelId   = 798,
        skillList =
        {
            xi.mobSkill.SHOCK_STRIKE,
            xi.mobSkill.THUNDER_II,
            xi.mobSkill.THUNDERSPARK,
            xi.mobSkill.ROLLING_THUNDER,
            xi.mobSkill.LIGHTNING_ARMOR,
            xi.mobSkill.THUNDER_IV,
        },
        twoHour   = xi.mobSkill.JUDGMENT_BOLT_1,
    },
}

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)

    local avatarChosen = math.random(1, #avatarTable)
    local avatarInfo  = avatarTable[avatarChosen]

    mob:setModelId(avatarInfo.modelId)
    mob:setLocalVar('avatarIndex', avatarChosen)
end

entity.onMobFight = function(mob, target)
    local avatarInfo = avatarTable[mob:getLocalVar('avatarIndex')]

    if not avatarInfo then
        return
    end

    if mob:getLocalVar('twoHourUsed') == 1 then
        mob:setLocalVar('twoHourUsed', 0)
        mob:useMobAbility(avatarInfo.twoHour)
    end

    if mob:getLocalVar('jobAbilityUsed') == 1 then
        mob:setLocalVar('jobAbilityUsed', 0)
        mob:useMobAbility(avatarInfo.skillList[math.random(1, #avatarInfo.skillList)])
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local avatarInfo = avatarTable[mob:getLocalVar('avatarIndex')]

    if not avatarInfo then
        return 0
    end

    return avatarInfo.skillList[math.random(1, #avatarInfo.skillList)]
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local currentTime = GetSystemTime()
        local fantoccini = mob:getMaster()

        if not fantoccini then
            return
        end

        fantoccini:setLocalVar('petSummonTime', currentTime + 45)
    end
end

return entity
