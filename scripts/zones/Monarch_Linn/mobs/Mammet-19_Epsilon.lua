-----------------------------------
-- Area: Monarch Linn
--  Mob: Mammet-19 Epsilon
-----------------------------------
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
    -- NOTE: Mammets always have access to:
    -- Transmogrification: Absorbs all physical damage for ~30 seconds
    -- Tremorous Tread: Low AoE damage with a Stun effect, absorbed by Utsusemi.
    [0] = { 487, 540 },
    -- Sword Skills:
    -- Velocious Blade: 5-hit attack, high da
    -- Sonic Blade: High AoE damage.
    -- Scission Thrust: Low conal AoE damage.
    [1] = { 347, 419, 422 },
    -- Percussive Foin: Medium directional AoE damage.
    -- Gravity Wheel: High AoE damage and Gravity.
    -- Microquake: High single-target damage.
    [2] = { 441, 447, 457 },
    -- Psychomancy: AoE Aspir, drains 80+ MP.
    -- Mind Wall: Gives the Mammet a special Magic Shield effect causing it to absorb offensive magic used against it for ~30 seconds.
    [3] = { 464, 471 },
}

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)
end

entity.onMobFight = function(mob, target)
    -- Chages forms after 30-60 seconds randomly
    local timeTracker = mob:getLocalVar("formTimeTracker")
    local currentTime = mob:getBattleTime()
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
                mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
                mob:setMagicCastingEnabled(true)
                mob:setDelay(3700)
                mob:setDamage(40)
            end,
        }
        mob:setLocalVar("formTimeTracker", mob:getBattleTime() + math.random(30, 60))
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    switch (mob:getAnimationSub()): caseof
    {
        [forms.UNARMED] = function()
            local wsChoice = math.random(1, 2)
            return tpMoves[forms.UNARMED][wsChoice]
        end,

        [forms.SWORD] = function()
            local wsChoice = math.random(1, 3)
            return tpMoves[forms.SWORD][wsChoice]
        end,

        [forms.POLEARM] = function()
            local wsChoice = math.random(1, 3)
            return tpMoves[forms.POLEARM][wsChoice]
        end,

        [forms.STAFF] = function()
            local wsChoice = math.random(1, 2)
            return tpMoves[forms.STAFF][wsChoice]
        end,
    }
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
