-----------------------------------
-- Area: Monarch Linn
--  Mob: Mammet-800
-----------------------------------
local monarchLinnID = zones[xi.zone.MONARCH_LINN]
-----------------------------------
---@type TMobEntity
local entity = {}

-- Additional battlefield Mammets will be added to keep track for win conditions for each battlefield.
local battlefieldMammets =
{
    [ monarchLinnID.mob.MAMMET_800      ] = { },
    [ monarchLinnID.mob.MAMMET_800 + 10 ] = { },
    [ monarchLinnID.mob.MAMMET_800 + 20 ] = { },
}

local forms =
{
    UNARMED = 0,
    SWORD   = 1,
    POLEARM = 2,
    STAFF   = 3,
}

local tpMoves =
{

    [forms.UNARMED] =
    {
        xi.mobSkill.TRANSMOGRIFICATION,
        xi.mobSkill.TREMOROUS_TREAD,
    },
    [forms.SWORD] =
    {
        xi.mobSkill.VELOCIOUS_BLADE,
        xi.mobSkill.SONIC_BLADE,
        xi.mobSkill.SCISSION_THRUST,
    },
    [forms.POLEARM] =
    {
        xi.mobSkill.PERCUSSIVE_FOIN,
        xi.mobSkill.GRAVITY_WHEEL,
        xi.mobSkill.MICROQUAKE,
    },
    [forms.STAFF] =
    {
        xi.mobSkill.PSYCHOMANCY,
        xi.mobSkill.MIND_WALL,
    },
}

-----------------------------------
-- Spawns additional mammets upon engagement based on player count.
-----------------------------------
local function spawnAdditionalMammets(mob, target)
    local parentID    = mob:getID()
    local battlefield = mob:getBattlefield()
    if not battlefield or not battlefieldMammets[parentID] then
        return
    end

    local players    = battlefield:getPlayers()
    local spawnCount = math.floor((#players - 1) / 2)

    mob:setLocalVar('parentMammet', parentID)
    battlefieldMammets[parentID][parentID] = true

    if spawnCount < 1 then
        return
    end

    for i = 1, spawnCount do
        local newMobID = parentID + i
        local newMob   = SpawnMob(newMobID)

        if newMob then
            newMob:setLocalVar('parentMammet', parentID)
            battlefieldMammets[parentID][newMobID] = true
            newMob:updateEnmity(target)
        end
    end
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
    mob:setLocalVar('engageDelay', mob:getBattleTime() + 5)
    spawnAdditionalMammets(mob, target)
end

entity.onMobFight = function(mob, target)
    -- Only enable movement and auto-attack after the initial delay.
    if mob:getBattleTime() >= mob:getLocalVar('engageDelay') then
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        mob:setAutoAttackEnabled(true)
    end

    -- Changes forms after 15-60 seconds randomly
    local timeTracker = mob:getLocalVar('formTimeTracker')
    local currentTime = mob:getBattleTime()
    -- NOTE: Yellow Liquid applies xi.effect.FOOD to the Mammets
    local cannotChangeForm = mob:hasStatusEffect(xi.effect.FOOD)

    if
        currentTime >= timeTracker and
        not cannotChangeForm
    then
        -- Pick a new form --
        local rand = math.random(0, 3)
        mob:setAnimationSub(rand)
        switch (rand): caseof
        {
            [forms.UNARMED] = function()
                mob:setMagicCastingEnabled(false)
                mob:setDelay(2400)
                mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
            end,

            [forms.SWORD] = function()
                mob:setMagicCastingEnabled(false)
                mob:setDelay(1200)
                mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
            end,

            [forms.POLEARM] = function()
                mob:setMagicCastingEnabled(false)
                mob:setDelay(3000)
                mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
            end,

            [forms.STAFF] = function()
                mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
                mob:setMagicCastingEnabled(true)
                mob:setDelay(2400)
                mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 100)
            end,
        }
        mob:setLocalVar('formTimeTracker', mob:getBattleTime() + math.random(15, 60))
    end
end

-----------------------------------
-- Select TP moves based on current form.
-----------------------------------
entity.onMobMobskillChoose = function(mob, target, skillId)
    local form  = mob:getAnimationSub()
    local moves = tpMoves[form]

    return moves[math.random(1, #moves)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.STONEGA_III,
        xi.magic.spell.WATERGA_III,
        xi.magic.spell.AEROGA_III,
        xi.magic.spell.FIRAGA_III,
        xi.magic.spell.BLIZZAGA_III,
        xi.magic.spell.THUNDAGA_III,
    }

    return spellList[math.random(#spellList)]
end

-----------------------------------
-- Check that all of the mobs from the battlefield have been defeated.
-----------------------------------
entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local parentMammet = mob:getLocalVar('parentMammet')
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
end

return entity
