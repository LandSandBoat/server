-----------------------------------
-- Area: Sealions Den
--  Mob: Mammet-22 Zeta
-----------------------------------
---@type TMobEntity
local entity = {}

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

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
end

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('formTimeTracker', GetSystemTime() + math.random(25, 60))
end

entity.onMobFight = function(mob, target)
    -- Chages forms after 30-60 seconds randomly
    local timeTracker = mob:getLocalVar('formTimeTracker')
    local currentTime = GetSystemTime()
    -- NOTE: Yellow Liquid applies xi.effect.FOOD to the Mammets
    local cannotChangeForm = mob:hasStatusEffect(xi.effect.FOOD)

    if currentTime >= timeTracker and not cannotChangeForm then
        -- Pick a new form --
        local rand = math.random(0, 3)
        mob:setAnimationSub(rand)
        switch (rand): caseof
        {
            [forms.UNARMED] = function()
                mob:setMagicCastingEnabled(false)
                mob:setDelay(2400)
                mob:setDamage(40)
            end,

            [forms.SWORD] = function()
                mob:setMagicCastingEnabled(false)
                mob:setDelay(1500)
                mob:setDamage(40)
            end,

            [forms.POLEARM] = function()
                mob:setMagicCastingEnabled(false)
                mob:setDelay(3250)
                mob:setDamage(75)
            end,

            [forms.STAFF] = function()
                mob:setMobMod(xi.mobMod.MAGIC_COOL, 10)
                mob:setMagicCastingEnabled(true)
                mob:setDelay(3700)
                mob:setDamage(40)
            end,
        }
        mob:setLocalVar('formTimeTracker', currentTime + math.random(25, 60))
    end
end

entity.onMobMobskillChoose = function(mob, target)
    local form  = mob:getAnimationSub()
    local moves = tpMoves[form]

    return moves[math.random(1, #moves)]
end

return entity
