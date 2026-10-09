-----------------------------------
-- Chocobo Racing: Field
-- Generated Chocobos for Circuit Races.
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

-- Every random bird starts from one of these templates.
local templates =
{
    { orders = xi.chocoboRacing.order.SPRINT,      item = xi.chocoboRacing.sectionEvent.SHADOW_APPLE,   stats = { str = 255, ['end'] = 255, dsc =   0, rcp =   0 } },
    { orders = xi.chocoboRacing.order.KEEP_PACE,   item = xi.chocoboRacing.sectionEvent.SPEED_APPLE,    stats = { str = 128, ['end'] = 192, dsc = 160, rcp = 160 } },
    { orders = xi.chocoboRacing.order.KEEP_PACE,   item = xi.chocoboRacing.sectionEvent.STAMINA_APPLE,  stats = { str = 192, ['end'] = 128, dsc = 192, rcp = 128 } },
    { orders = xi.chocoboRacing.order.KEEP_PACE,   item = xi.chocoboRacing.sectionEvent.PEPPER_BISCUIT, stats = { str = 224, ['end'] = 192, dsc =  96, rcp = 128 } },
    { orders = xi.chocoboRacing.order.KEEP_PACE,   item = xi.chocoboRacing.sectionEvent.FIRE_BISCUIT,   stats = { str = 128, ['end'] =  96, dsc = 224, rcp = 192 } },
    { orders = xi.chocoboRacing.order.FINAL_SPURT, item = xi.chocoboRacing.sectionEvent.SPEED_APPLE,    stats = { str = 255, ['end'] = 255, dsc = 128, rcp =   0 } },
    { orders = xi.chocoboRacing.order.FINAL_SPURT, item = xi.chocoboRacing.sectionEvent.GYSAHL_BOMB,    stats = { str = 192, ['end'] =   0, dsc = 192, rcp = 255 } },
    { orders = xi.chocoboRacing.order.FINAL_SPURT, item = xi.chocoboRacing.sectionEvent.GYSAHL_BOMB,    stats = { str = 255, ['end'] = 255, dsc =  64, rcp =  64 } },
}

-- How random birds differ from their template and from each other.
local randomBird =
{
    -- Most birds keep the template's stats.
    -- Occasionally, they get scaled a few percent either way.
    -- A few of them get scaled down to much lower values.
    smallScalePercent    = 13,            -- 13% of chocobos get a small adjustment
    smallScale           = { 990, 1030 }, -- 99% to 103% of their base stats, in thousandths
    largeScalePercent    = 1,             -- 1% of chocobos get a larger adjustment
    largeScale           = { 645, 830 },  -- 64.5% to 83% of their base stats, in thousandths

    -- About a third of birds have no ability.
    -- A fifth get blessed with 2 abilities.
    -- Chocobos with 2x Gallop have been observed on retail.
    noAbilityPercent     = 34,
    secondAbilityPercent = 23,

    -- Names are chocobo names with ids in this range, every name of 3 letters or more.
    nameIds              = { 12, 830 },

    -- Color distribution
    color                =
    {
        { xi.chocoboRaising.color.YELLOW, 41 },
        { xi.chocoboRaising.color.BLACK,  25 },
        { xi.chocoboRaising.color.BLUE,   12 },
        { xi.chocoboRaising.color.RED,    13 },
        { xi.chocoboRaising.color.GREEN,  9 },
    },

    -- Preferred weather distribution
    weather              =
    {
        { xi.chocoboRaising.weather.CLEAR,        57 },
        { xi.chocoboRaising.weather.RAINY,        34 },
        { xi.chocoboRaising.weather.HOT_SUNNY,    2 },
        { xi.chocoboRaising.weather.SANDSTORMS,   2 },
        { xi.chocoboRaising.weather.WINDY,        2 },
        { xi.chocoboRaising.weather.SNOWY,        2 },
        { xi.chocoboRaising.weather.THUNDERSTORM, 1 },
    },
}

-- A handful of chocobos show up in a recurring fashion on specific races.
local stars =
{
    SHILVER_CHARIOT =
    {
        name        = 'ShilverChariot',
        orders      = xi.chocoboRacing.order.SPRINT,
        item        = xi.chocoboRacing.sectionEvent.SHADOW_APPLE,
        weather     = xi.chocoboRaising.weather.CLEAR,
        color       = xi.chocoboRaising.color.RED,
        gender      = xi.chocoboRaising.gender.MALE,
        size        = xi.chocoboRacing.jockeySize.HUME_M,
        ability1    = xi.chocoboRaising.ability.GALLOP,
        ability2    = xi.chocoboRaising.ability.AUTO_REGEN,
        temperament = xi.chocoboRaising.temperament.VERY_EASYGOING,
        stats       = { str = 191, ['end'] = 200, dsc = 100, rcp = 150 },
    },
    LUNAR_HARVESTER =
    {
        name        = 'LunarHarvester',
        orders      = xi.chocoboRacing.order.KEEP_PACE,
        item        = xi.chocoboRacing.sectionEvent.STAMINA_APPLE,
        weather     = xi.chocoboRaising.weather.CLEAR,
        color       = xi.chocoboRaising.color.GREEN,
        gender      = xi.chocoboRaising.gender.FEMALE,
        size        = xi.chocoboRacing.jockeySize.HUME_M,
        ability1    = xi.chocoboRaising.ability.CANTER,
        ability2    = xi.chocoboRaising.ability.AUTO_REGEN,
        temperament = xi.chocoboRaising.temperament.VERY_EASYGOING,
        stats       = { str = 200, ['end'] = 190, dsc = 151, rcp = 100 },
    },
    MEGA_FLARE =
    {
        name        = 'MegaFlare',
        orders      = xi.chocoboRacing.order.FINAL_SPURT,
        item        = xi.chocoboRacing.sectionEvent.GYSAHL_BOMB,
        weather     = xi.chocoboRaising.weather.CLEAR,
        color       = xi.chocoboRaising.color.BLUE,
        gender      = xi.chocoboRaising.gender.MALE,
        size        = xi.chocoboRacing.jockeySize.HUME_M,
        ability1    = xi.chocoboRaising.ability.GALLOP,
        ability2    = xi.chocoboRaising.ability.CANTER,
        temperament = xi.chocoboRaising.temperament.VERY_EASYGOING,
        stats       = { str = 194, ['end'] = 195, dsc = 124, rcp = 124 },
    },
}

-- Chance for a star to join a given race
local starJoinPercent = 31

-- When each star Chocobo has a chance to join, by race number % 8.
local starCycle =
{
    [2] = { { lane = 1, bird = stars.SHILVER_CHARIOT } },
    [3] = { { lane = 1, bird = stars.MEGA_FLARE }, { lane = 2, bird = stars.LUNAR_HARVESTER } },
    [6] = { { lane = 1, bird = stars.SHILVER_CHARIOT } },
    [7] = { { lane = 1, bird = stars.MEGA_FLARE }, { lane = 2, bird = stars.LUNAR_HARVESTER } },
}

--- Picks a value from { value, percent } entries.
---@param odds integer[][]
---@return integer
xi.chocoboRacing.rollOdds = function(odds)
    local roll = math.randomInt(1, 100)
    for _, entry in ipairs(odds) do
        roll = roll - entry[2]
        if roll <= 0 then
            return entry[1]
        end
    end

    return odds[#odds][1]
end

local racerNames = nil

--- Fills every lane with a random bird, then puts this race's stars in their lanes.
-- TODO: This is where we insert player chocobos.
---@param raceNo integer
---@return ChocoboRacer[]
xi.chocoboRacing.drawField = function(raceNo)
    if not racerNames then
        racerNames = {}
        for id = randomBird.nameIds[1], randomBird.nameIds[2] do
            if xi.chocoboNames[id] then
                table.insert(racerNames, xi.chocoboNames[id])
            end
        end
    end

    local chocobos = {}
    local taken    = {}
    for lane = 1, xi.chocoboRacing.simulator.rules.field.autoRacers do
        -- Pick a random template
        local template = utils.randomEntry(templates)

        -- Occasionally we adjust their stats
        local scale    = 1000
        local roll     = math.randomInt(1, 100)
        if roll <= randomBird.largeScalePercent then
            scale = math.randomInt(randomBird.largeScale[1], randomBird.largeScale[2])
        elseif roll <= randomBird.largeScalePercent + randomBird.smallScalePercent then
            scale = math.randomInt(randomBird.smallScale[1], randomBird.smallScale[2])
        end

        -- Assign them random abilities
        local ability1 = xi.chocoboRaising.ability.NONE
        local ability2 = xi.chocoboRaising.ability.NONE
        if math.randomInt(1, 100) > randomBird.noAbilityPercent then
            ability1 = math.randomInt(xi.chocoboRaising.ability.GALLOP, xi.chocoboRaising.ability.TREASURE_FINDER)
            if math.randomInt(1, 100) <= randomBird.secondAbilityPercent then
                ability2 = math.randomInt(xi.chocoboRaising.ability.GALLOP, xi.chocoboRaising.ability.TREASURE_FINDER)
                if ability2 == ability1 then
                    ability2 = xi.chocoboRaising.ability.GALLOP
                end
            end
        end

        local stats = {}
        for stat, value in pairs(template.stats) do
            stats[stat] = math.min(math.floor(value * scale / 1000), 255)
        end

        -- Give them a random unique name
        local name = utils.randomEntry(racerNames)
        while taken[name] do
            name = utils.randomEntry(racerNames)
        end

        taken[name] = true

        chocobos[lane] =
        {
            name        = name,
            orders      = template.orders,
            item        = template.item,
            weather     = xi.chocoboRacing.rollOdds(randomBird.weather),
            color       = xi.chocoboRacing.rollOdds(randomBird.color),
            gender      = math.randomInt(xi.chocoboRaising.gender.MALE, xi.chocoboRaising.gender.FEMALE),
            size        = math.randomInt(xi.chocoboRacing.jockeySize.HUME_M, xi.chocoboRacing.jockeySize.HUME_F),
            ability1    = ability1,
            ability2    = ability2,
            temperament = math.randomInt(xi.chocoboRaising.temperament.VERY_EASYGOING, xi.chocoboRaising.temperament.ENIGMATIC),
            stats       = stats,
        }
    end

    -- Check if Star Chocobos are eligible for the current race
    -- They are not guaranteed to join
    for _, star in ipairs(starCycle[raceNo % 8] or {}) do
        if math.randomInt(1, 100) <= starJoinPercent then
            chocobos[star.lane] = star.bird
        end
    end

    return chocobos
end
