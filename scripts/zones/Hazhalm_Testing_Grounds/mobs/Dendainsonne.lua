-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Dendainsonne (Einherjar)
-- Notes: Responds to incoming damage with emotes, indicating internal rage state
-- When rage reaches 2, Dendainsonne will cast an instant-cast Meteor
-- Level 0: Dendainsonne looks angry...
-- Level 1: Dendainsonne is enraged!
-- Level 2 (waiting on Meteor CD): Dendainsonne is out of control!
-- Level 2: Dendainsonne appears to be mocking you...
-- 30 seconds CD on Meteor and has native aspirable MP.
-- Immune to Silence and has Triple Attack
-- TODO: Unknown exact damage threshold for increasing rage
-----------------------------------
mixins =
{
    require('scripts/mixins/draw_in'),
}
local ID = zones[xi.zone.HAZHALM_TESTING_GROUNDS]
-----------------------------------
---@type TMobEntity
local entity = {}

local function notBusy(mob)
    local action = mob:getCurrentAction()
    if
        action == xi.action.MOBABILITY_START or
        action == xi.action.MOBABILITY_USING or
        action == xi.action.MOBABILITY_FINISH or
        action == xi.action.MAGIC_CASTING or
        action == xi.action.MAGIC_START or
        action == xi.action.MAGIC_FINISH
    then
        return false
    end

    return true
end

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMod(xi.mod.UFASTCAST, 100)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
    mob:setMaxMP(5000)
end

entity.onMobSpawn = function(mob)
    mob:setMP(5000)

    mob:setLocalVar('rageLevel', 0)
    mob:setLocalVar('meteorCD', 0)
    mob:setLocalVar('meteorQueued', 0)

    mob:addListener('TAKE_DAMAGE', 'RAGE_INCREASE', function(mobArg, amount, attacker, attackType, damageType)
        -- Numbers are best guess based on captures and need to be refined.
        -- Considering this was tuned for ToAU 75 era, the exact dmg threshold is likely between 200 and 1000
        -- The increases appear to be guaranteed if you meet the conditions
        -- There is likely a 2-3 seconds cooldown in between possible increases
        if
            mobArg:getLocalVar('rageIncreaseCD') > GetSystemTime() or
            amount < 300
        then
            return
        end

        local rageLevel = math.min(mobArg:getLocalVar('rageLevel') + 1, 2)
        if rageLevel == 2 then
            if
                mobArg:getLocalVar('meteorCD') <= GetSystemTime() and
                notBusy(mob) and
                mobArg:getLocalVar('meteorQueued') ~= 1
            then
                mobArg:messageText(mob, ID.text.DENDAINSONNE_MOCKING_YOU, false)
                mobArg:setLocalVar('meteorQueued', 1)
                mobArg:castSpell(xi.magic.spell.METEOR, attacker)
            else
                mobArg:messageText(mob, ID.text.DENDAINSONNE_OUT_OF_CONTROL, false)
            end

            mobArg:setLocalVar('rageLevel', 2)
        else
            mobArg:messageText(mob, ID.text.DENDAINSONNE_ENRAGED, false)
            mobArg:setLocalVar('rageLevel', 1)
        end

        mobArg:setLocalVar('rageIncreaseCD', GetSystemTime() + 3)
    end)

    mob:addListener('MAGIC_STATE_EXIT', 'DENDAINSONNE_MAGIC_EXIT', function(mobArg, spell)
        if spell:getID() == xi.magic.spell.METEOR then
            mobArg:setLocalVar('rageLevel', 0)
            mobArg:setLocalVar('meteorCD', GetSystemTime() + 30)
            mobArg:setLocalVar('meteorQueued', 0)
        end
    end)
end

-- Notify players outside of the damage listener once in a while
entity.onMobFight = function(mob, target)
    local notifyCD = mob:getLocalVar('notifyCD')
    local meteorCD = mob:getLocalVar('meteorCD')

    if
        not notBusy(mob) or
        notifyCD > GetSystemTime()
    then
        return
    end

    local rageLevel = mob:getLocalVar('rageLevel')

    if rageLevel == 0 then
        mob:messageText(mob, ID.text.DENDAINSONNE_ANGRY, false)
    elseif rageLevel == 1 then
        mob:messageText(mob, ID.text.DENDAINSONNE_ENRAGED, false)
    elseif rageLevel == 2 and meteorCD > GetSystemTime() then
        mob:messageText(mob, ID.text.DENDAINSONNE_OUT_OF_CONTROL, false)
    end

    mob:setLocalVar('notifyCD', GetSystemTime() + 12)
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == xi.magic.spell.METEOR then
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setAnimation(280)
        spell:setMPCost(0)
    end
end

return entity
