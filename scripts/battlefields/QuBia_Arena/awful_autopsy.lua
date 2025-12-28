-----------------------------------
-- An Awful Autopsy
-- Qu'Bia Arena BCNM50, Comet Orb
-- !additem 1177
-- NOTE : The wiki claims that the adds spawn at HP intervals and has been proven incorrect with captures. They actually spawn based on timed intervals.
-- The timing has been verified with captures, these spawn even if the stomach is not in combat.
-- The battlefield doesn't end automatically when the stomach is defeated unless it's the only mob alive, so players can win early if they defeat the stomach before any adds spawn.
-- You're incentivized to defeat the stomach quickly to avoid having to deal with the adds and Chahnameed himself.
-- Chahnameed spawning is clearly meant to be an enrage mechanic, if he spawns, you have no hope of winning.
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.QUBIA_ARENA,
    battlefieldId    = xi.battlefield.id.AWFUL_AUTOPSY,
    maxPlayers       = 3,
    levelCap         = 50,
    timeLimit        = utils.minutes(15),
    index            = 15,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.COMET_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        qubiaID.mob.CHAHNAMEEDS_STOMACH + 4,
        qubiaID.mob.CHAHNAMEEDS_STOMACH + 9,
        qubiaID.mob.CHAHNAMEEDS_STOMACH + 14,
    },
})

-- We will call this function whenever one of the mobs in the battlefield dies to allow for early victory.
local function handleDeath(battlefield, mob)
    local baseId = qubiaID.mob.CHAHNAMEEDS_STOMACH + (battlefield:getArea() - 1) * 5

    for i = 0, 3 do
        local entity = GetMobByID(baseId + i)
        if entity and entity:isAlive() then
            return
        end
    end

    content:handleAllMonstersDefeated(battlefield, mob)
end

content.groups =
{
    {
        mobIds =
        {
            { qubiaID.mob.CHAHNAMEEDS_STOMACH      }, -- Chahnameed's Stomach
            { qubiaID.mob.CHAHNAMEEDS_STOMACH +  5 }, -- Chahnameed's Stomach
            { qubiaID.mob.CHAHNAMEEDS_STOMACH + 10 }, -- Chahnameed's Stomach
        },

        death = handleDeath,
    },

    {
        mobIds =
        {
            {
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 1,  -- Chahnameed's Intestine
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 2,  -- Chahnameed's Liver
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 3,  -- Chahnameed
            },

            {
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 6,  -- Chahnameed's Intestine
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 7,  -- Chahnameed's Liver
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 8,  -- Chahnameed
            },

            {
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 11, -- Chahnameed's Intestine
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 12, -- Chahnameed's Liver
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 13, -- Chahnameed
            },
        },

        death   = handleDeath,
        spawned = false,
    },
}

-- Table of timed spawns for Chahnameed and his organs. Intestine at 8 minutes, Liver at 6 minutes, Chahnameed at 2 minutes.
local timedSpawns =
{
-- [phase] = { time, offset }
    [0] = { 480, 1 },
    [1] = { 360, 2 },
    [2] = { 120, 3 },
}

function content:onBattlefieldTick(battlefield, tick)
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    local phase = battlefield:getLocalVar('Phase')
    if phase == 3 then
        return
    end

    -- Find out what battlefield we're in and fetch the correct base ID
    local stomachID = qubiaID.mob.CHAHNAMEEDS_STOMACH + (battlefield:getArea() - 1) * 5
    local stomach   = GetMobByID(stomachID)

    -- If Chahnameed's Stomach is defeated, nothing else to do here.
    if not stomach or not stomach:isAlive() then
        return
    end

    -- Fetch position and target of the stomach every tick to have it ready for spawning adds.
    if battlefield:getRemainingTime() <= timedSpawns[phase][1] then
        battlefield:setLocalVar('Phase', phase + 1)

        local addEntityId = stomachID + timedSpawns[phase][2]
        local addEntity   = GetMobByID(addEntityId)
        if not addEntity then
            return
        end

        local stomachPosition = stomach:getPos()
        addEntity:setSpawn(stomachPosition.x + math.random(-1, 1) * 0.5, stomachPosition.y, stomachPosition.z + math.random(-1, 1) * 0.5, stomachPosition.rot)

        SpawnMob(addEntityId)

        -- Have the freshly spawned add attack the stomachs target
        local stomachTarget = stomach:getTarget()
        if stomachTarget then
            addEntity:updateEnmity(stomachTarget)
        end
    end
end

content.loot =
{
    {
        { itemId = xi.item.GIL,                      weight = 10000, amount = 15000 },
    },

    {
        quantity = 3,
        { itemId = xi.item.UNDEAD_SKIN,              weight = 10000 },
    },

    {
        quantity = 2,
        { itemId = xi.item.MANA_CIRCLET,             weight =   620 },
        { itemId = xi.item.RIVAL_RIBBON,             weight =   620 },
        { itemId = xi.item.SHOCK_MASK,               weight =   620 },
        { itemId = xi.item.SUPER_RIBBON,             weight =   620 },
        { itemId = xi.item.IVORY_MITTS,              weight =   620 },
        { itemId = xi.item.RUSH_GLOVES,              weight =   620 },
        { itemId = xi.item.SLY_GAUNTLETS,            weight =   620 },
        { itemId = xi.item.SPIKED_FINGER_GAUNTLETS,  weight =   620 },
        { itemId = xi.item.ESOTERIC_MANTLE,          weight =   620 },
        { itemId = xi.item.HEAVY_MANTLE,             weight =   620 },
        { itemId = xi.item.SNIPERS_MANTLE,           weight =   620 },
        { itemId = xi.item.TEMPLARS_MANTLE,          weight =   620 },
        { itemId = xi.item.BENIGN_NECKLACE,          weight =   620 },
        { itemId = xi.item.HATEFUL_COLLAR,           weight =   620 },
        { itemId = xi.item.INTELLECT_TORQUE,         weight =   620 },
        { itemId = xi.item.STORM_GORGET,             weight =   620 },
    },

    {
        quantity = 2,
        { itemId = xi.item.MAHOGANY_LOG,             weight =   400 },
        { itemId = xi.item.EBONY_LOG,                weight =   400 },
        { itemId = xi.item.PETRIFIED_LOG,            weight =   400 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =   400 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,        weight =   400 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =   400 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =   400 },
        { itemId = xi.item.MYTHRIL_INGOT,            weight =   400 },
        { itemId = xi.item.GOLD_INGOT,               weight =   400 },
        { itemId = xi.item.DARKSTEEL_INGOT,          weight =   400 },
        { itemId = xi.item.PLATINUM_INGOT,           weight =   400 },
        { itemId = xi.item.RAM_HORN,                 weight =   400 },
        { itemId = xi.item.CORAL_FRAGMENT,           weight =   400 },
        { itemId = xi.item.DEMON_HORN,               weight =   400 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =   400 },
        { itemId = xi.item.RAM_SKIN,                 weight =   400 },
        { itemId = xi.item.MANTICORE_HIDE,           weight =   400 },
        { itemId = xi.item.WYVERN_SKIN,              weight =   400 },
        { itemId = xi.item.SCROLL_OF_FREEZE,         weight =   400 },
        { itemId = xi.item.SCROLL_OF_QUAKE,          weight =   400 },
        { itemId = xi.item.SCROLL_OF_RAISE_II,       weight =   400 },
        { itemId = xi.item.SCROLL_OF_REGEN_III,      weight =   400 },
        { itemId = xi.item.FIRE_SPIRIT_PACT,         weight =   400 },
        { itemId = xi.item.LIGHT_SPIRIT_PACT,        weight =   400 },
        { itemId = xi.item.RERAISER,                 weight =   200 },
        { itemId = xi.item.VILE_ELIXIR,              weight =   200 },
    },
}

return content:register()
