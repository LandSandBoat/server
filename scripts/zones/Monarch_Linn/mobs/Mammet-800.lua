-----------------------------------
-- Area: Monarch Linn
--  Mob: Mammet-800
-----------------------------------
local monarchLinnID = zones[xi.zone.MONARCH_LINN]
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO: Get staff delay.
-- TODO: Tweak attack speeds.
-- TODO: Investigate form damage.
-- TODO: Get Ninjutsu and Song resistances.

-- Additional battlefield Mammets will be added to keep track for win conditions for each battlefield.
local battlefieldMammets =
{
    [ monarchLinnID.mob.MAMMET_800      ] = { },
    [ monarchLinnID.mob.MAMMET_800 + 10 ] = { },
    [ monarchLinnID.mob.MAMMET_800 + 20 ] = { },
}

-- Run time TP move container.
local tpMoves = { }

local modes =
{
    UNARMED = 0,
    SWORD   = 1,
    POLEARM = 2,
    STAFF   = 3,
}

local modeData =
{
    [modes.UNARMED] =
    {
        tpMoves  =
        {
            xi.mobSkill.TRANSMOGRIFICATION,
            xi.mobSkill.TREMOROUS_TREAD,
        },
        isCaster = false,
        delay    = 3040,
        damage   = 40,
    },

    [modes.SWORD] =
    {
        tpMoves  =
        {
            xi.mobSkill.VELOCIOUS_BLADE,
            xi.mobSkill.SCISSION_THRUST,
            xi.mobSkill.SONIC_BLADE,
        },
        isCaster = false,
        delay    = 2090,
        damage   = 40,
    },

    [modes.POLEARM] =
    {
        tpMoves  =
        {
            xi.mobSkill.MICROQUAKE,
            xi.mobSkill.PERCUSSIVE_FOIN,
            xi.mobSkill.GRAVITY_WHEEL,
        },
        isCaster = false,
        delay    = 5060,
        damage   = 75,
    },

    [modes.STAFF] =
    {
        tpMoves  =
        {
            xi.mobSkill.PSYCHOMANCY,
            xi.mobSkill.MIND_WALL,
        },
        isCaster = true,
        delay    = 4100,
        damage   = 40,
    },
}

-----------------------------------
-- Switches the mammet to a new battle mode.
-----------------------------------
local modeSwitch = function(mob, newMode)
    -- Avoid the same mode twice in a row.
    if not newMode then
        local currentMode = mob:getAnimationSub()

        repeat
            newMode = math.random(modes.UNARMED, modes.STAFF)
        until newMode ~= currentMode
    end

    local details = modeData[newMode]
    tpMoves = { }

    -- Add base Mammet move set.
    for _, skillID in ipairs(modeData[modes.UNARMED].tpMoves) do
        table.insert(tpMoves, skillID)
    end

    -- Add weapon move set.
    if newMode ~= modes.UNARMED then
        for _, skillID in ipairs(details.tpMoves) do
            table.insert(tpMoves, skillID)
        end
    end

    mob:setAnimationSub(newMode)
    mob:setMagicCastingEnabled(details.isCaster)
    mob:setDelay(details.delay)
    mob:setDamage(details.damage)
end

-----------------------------------
-- Spawns additional mammets upon engagement based on player count.
-----------------------------------
local spawnAdditionalMammets = function(mob, target)
    local parentID = mob:getID()

    if battlefieldMammets[parentID] then
        local players = mob:getBattlefield():getPlayers()

        mob:setLocalVar('parentMammet', parentID)
        battlefieldMammets[parentID][mob:getID()] = true

        for i = 3, #players, 2 do
            if i >= 19 then
                break
            end

            local newMobID = parentID + i
            local newMob   = SpawnMob(newMobID)

            if newMob then
                newMob:setLocalVar('parentMammet', parentID)
                battlefieldMammets[parentID][newMobID] = true
                newMob:updateEnmity(target)
            end
        end
    end
end

-----------------------------------
-- Sets the next form switch time.
-----------------------------------
local scheduleModeSwitch = function(mob, time)
    time = time or mob:getBattleTime()
    mob:setLocalVar('nextFormTime', time + math.random(50, 60))
end

-----------------------------------
-- Initial immunities.
-----------------------------------
entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 20)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 18)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

-----------------------------------
-- Disable casting until staff form is attained.
-- The initial H2H phase has slower attack speed before switching.
-- Will not move or auto-attack for 8 seconds after engagement.
-----------------------------------
entity.onMobSpawn = function(mob)
    modeSwitch(mob, modes.UNARMED)
    mob:setDelay(4070)
    mob:setLocalVar('engageDelay', 0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
end

-----------------------------------
-- The mode switch timer starts when the mammet engages.
-- The first mammet will spawn additional mammets based on the number of players.
-----------------------------------
entity.onMobEngage = function(mob, target)
    mob:setLocalVar('engageDelay', mob:getBattleTime() + 8)
    spawnAdditionalMammets(mob, target)
    scheduleModeSwitch(mob)
end

-----------------------------------
-- Form switch controller.
-----------------------------------
entity.onMobFight = function(mob, target)
    local currentTime = mob:getBattleTime()
    local engageDelay = mob:getLocalVar('engageDelay')

    if
        currentTime >= mob:getLocalVar('nextFormTime') and
        mob:canUseAbilities() and
        not mob:hasStatusEffect(xi.effect.FOOD)     -- Yellow Liquid
    then
        modeSwitch(mob)
        scheduleModeSwitch(mob, currentTime)
    end

    -- Initial battle engagement delay.
    if engageDelay ~= 0 and currentTime >= engageDelay then
        mob:setLocalVar('engageDelay', 0)
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        mob:setAutoAttackEnabled(true)
    elseif engageDelay ~= 0 then
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    end
end

-----------------------------------
-- Select TP moves based on current form.
-----------------------------------
entity.onMobMobskillChoose = function(mob, target)
    local selectedMove = math.random(1, #tpMoves)

    return tpMoves[selectedMove]
end

-----------------------------------
-- Check that all of the mobs from the battlefield have been defeated.
-----------------------------------
entity.onMobDeath = function(mob, player, optParams)
    local parentMammet     = mob:getLocalVar('parentMammet')
    local battlefieldGroup = battlefieldMammets[parentMammet]

    if not battlefieldGroup then
        return
    end

    for id, _ in pairs(battlefieldGroup) do
        local checkMob = GetMobByID(id)

        if checkMob and checkMob:isAlive() then
            return
        end
    end

    local battlefield = mob:getBattlefield()
    battlefieldMammets[parentMammet] = { }

    if battlefield then
        battlefield:setStatus(xi.battlefield.status.WON)
    end
end

return entity
