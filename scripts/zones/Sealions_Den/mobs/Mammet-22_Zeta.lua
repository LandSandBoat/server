-----------------------------------
-- Area: Sealions Den
--  Mob: Mammet-22 Zeta
-----------------------------------
local oneToBeFeared = require("scripts/zones/Sealions_Den/bcnms/one_to_be_feared_helper")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
end

local forms =
{
    UNARMED = 0,
    SWORD   = 1,
    POLEARM = 2,
    STAFF   = 3,
}

local tpMoves =
{

    [0] = -- h2h Skills
    {
        487, -- Transmogrification: Absorbs all physical damage for ~30 seconds
        540, -- Tremorous Tread: Low AoE damage with a Stun effect, absorbed by Utsusemi.
    },
    [1] =      -- Sword Skills:
    {
        347, -- Velocious Blade: 5-hit attack
        419, -- Sonic Blade: High AoE damage.
        422, -- Scission Thrust: Low conal AoE damage.
    },
    [2] = -- Polearm Skills:
    {
        441, -- Percussive Foin: Medium directional AoE damage.
        447, -- Gravity Wheel: High AoE damage and Gravity.
        457, -- Microquake: High single-target damage.
    },
    [3] = -- Staff Skills
    {
        464, -- Psychomancy: AoE Aspir, drains 80+ MP.
        471, -- Mind Wall: Gives the Mammet a special Magic Shield effect causing it to absorb offensive magic used against it for ~30 seconds.
    },
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
                mob:setMobMod(xi.mobMod.MAGIC_COOL, 10)
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
    oneToBeFeared.handleMammetDeath(mob, player, optParams)
end

entity.onEventFinish = function(player, csid, option)
    oneToBeFeared.handleMammetBattleEnding(player, csid, option)
end

return entity
