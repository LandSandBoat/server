-----------------------------------
-- Area: Sealions Den
--  Mob: Mammet-22 Zeta
-----------------------------------
local ID = require("scripts/zones/Sealions_Den/IDs")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    mob:setLocalVar("formHealthTracker", 100)
end

local forms =
{
    UNARMED = 0,
    SWORD   = 1,
    POLEARM = 2,
    STAFF   = 3,
}

entity.onMobSpawn = function(mob)
    mob:SetMagicCastingEnabled(false)
end

entity.onMobFight = function(mob, target)
    -- TODO: What are the conditions for a Mammet to change forms?
    --       For now we'll change forms every 20% health
    local healthTracker = mob:getLocalVar("formHealthTracker")
    local currentHealth = mob:getHPP()

    -- NOTE: Yellow Liquid applies xi.effect.FOOD to the Mammets
    local cannotChangeForm = mob:hasStatusEffect(xi.effect.FOOD)

    if healthTracker - currentHealth > 20 and not cannotChangeForm then
        -- Pick a new form
        local rand = math.random(0, 3)
        mob:setAnimationSub(rand)
        switch (rand): caseof
        {
            [forms.UNARMED] = function()
                mob:SetMagicCastingEnabled(false)
                mob:setDelay(2400)
                mob:setDamage(40)
            end,
            [forms.SWORD] = function()
                mob:SetMagicCastingEnabled(false)
                mob:setDelay(1500)
                mob:setDamage(40)
            end,
            [forms.POLEARM] = function()
                mob:SetMagicCastingEnabled(false)
                mob:setDelay(3250)
                mob:setDamage(75)
            end,
            [forms.STAFF] = function()
                mob:setMobMod(xi.mobMod.MAGIC_COOL, 10)
                mob:SetMagicCastingEnabled(true)
                mob:setDelay(3700)
                mob:setDamage(40)
            end,
        }
        mob:setLocalVar("formHealthTracker", currentHealth)
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    -- NOTE: Mammets always have access to:
    -- TODO: Transmogrification: Absorbs all physical damage for ~30 seconds
    -- TODO: Tremorous Tread: Low AoE damage with a Stun effect, absorbed by Utsusemi.
    switch (mob:getAnimationSub()): caseof
    {
        [forms.UNARMED] = function()
            -- Just default moves
        end,
        [forms.SWORD] = function()
            -- TODO: Velocious Blade: 5-hit attack, high damage.
            -- TODO: Sonic Blade: High AoE damage.
            -- TODO: Scission Thrust: Low conal AoE damage.
        end,
        [forms.POLEARM] = function()
            -- TODO: Percussive Foin: Medium directional AoE damage.
            -- TODO: Microquake: High single-target damage.
            -- TODO: Gravity Wheel: High AoE damage and Gravity.
        end,
        [forms.STAFF] = function()
            -- TODO: Psychomancy: AoE Aspir, drains 80+ MP.
            -- TODO: Mind Wall: Gives the Mammet a special Magic Shield effect causing it to absorb offensive magic used against it for ~30 seconds.
        end,
    }
end

entity.onMobDeath = function(mob, player, isKiller)
    -- find mob offset for given battlefield instance
    local battlefield = mob:getBattlefield()
    local inst = battlefield:getArea()
    local instOffset = ID.mob.ONE_TO_BE_FEARED_OFFSET + (7 * (inst - 1))

    -- if all five mammets in this instance are dead, start event
    local allMammetsDead = true
    for i = instOffset + 0, instOffset + 4 do
        if not GetMobByID(i):isDead() then
            allMammetsDead = false
            break
        end
    end

    local mammetEventGuard = battlefield:getLocalVar("mammetEventGuard")
    if allMammetsDead and mammetEventGuard == 0 then
        player:startEvent(11)
        battlefield:setLocalVar("mammetEventGuard", 1)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 11 then
        local battlefield = player:getBattlefield()
        local inst = battlefield:getArea()

        -- players are healed in between fights, but their TP is set to 0
        player:addTitle(xi.title.BRANDED_BY_LIGHTNING)
        player:setHP(player:getMaxHP())
        player:setMP(player:getMaxMP())
        player:setTP(0)

        player:setLocalVar("[OTBF]cs", 1)

        -- move player to instance
        if inst == 1 then
            player:setPos(-779, -103, -80)
        elseif inst == 2 then
            player:setPos(-140, -23, -440)
        elseif inst == 3 then
            player:setPos(499, 56, -802)
        end
    end
end

return entity
