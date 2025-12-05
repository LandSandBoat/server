-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree X
-- TODO: Rework based off of Head Wind changes
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO: Add sleep resistance.
-- TODO: Add gravity resistance.
-- TODO: Adjust ninjutsu weights.
-- TODO: Ninjutsu and Song immunities.

local boneyardID = zones[xi.zone.BONEYARD_GULLY]
local skillList  = 1165

-- Indexed by step in the skillchain.
local weaponskills =
{
    [ 1 ] = xi.weaponskill.EVISCERATION,
    [ 2 ] = xi.weaponskill.SHADOWSTITCH,
}

local messages =
{
    ENGAGE           = 0,
    TP_READY         = boneyardID.text.READY_TO_RUMBLE,
    BEGIN_SKILLCHAIN = boneyardID.text.TIME_TO_HUNT,
    CLOSE_SKILLCHAIN = boneyardID.text.MY_TURN,
    SOLO_WEAPONSKILL = boneyardID.text.YOURE_MINE,
    USE_TWO_HOUR     = boneyardID.text.SHIKAREE_X_2HR,
    CALL_BEAST       = boneyardID.text.DINNER_TIME_ADVENTURER_STEAK,
    DEATH            = boneyardID.text.EVEN_AT_MY_BEST,
}

-----------------------------------
-- Reset the skillchain variables.
-----------------------------------
local skillchainReset = function(mob)
    mob:setLocalVar('hasTP', 0)
    mob:setLocalVar('scStep', 0)
    mob:setLocalVar('wsTime', 0)
    mob:setLocalVar('chatBlock', 0)
    mob:setLocalVar('wsBlock', 0)
end

-----------------------------------
-- Are the conditions set that a skillchain is plausible?
-- 1. Skillchain partner is alive
-- 2. Skillchain partner is attacking the same mob.
-- 3. We have TP.
-----------------------------------
local isPrimedForSkillchain = function(mob, target, scPartner)
    if
        not scPartner:isAlive() or
        target:getID() ~= scPartner:getTarget():getID()
    then
        mob:setMobMod(xi.mobMod.SKILL_LIST, skillList)
        skillchainReset(mob)
        return false

    elseif mob:getTP() < 1000 then
        mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
        return false
    end

    mob:setMobMod(xi.mobMod.SKILL_LIST, 0)

    return true
end

-----------------------------------
-- Handle skillchain logistics: who is the lead and when will the weaponskills go off?
-- Disabled spell casts temporarily during the skillchain to prevent spell casts from ruining it.
-----------------------------------
local skillchainHandler = function(mob, scPartner, scStep)
    mob:setLocalVar('hasTP', 1)

    -- Skillchain in progress.
    if scPartner:getLocalVar('wsTime') > 0 or mob:getLocalVar('wsTime') > 0 then
        return
    end

    -- We are the first one to get TP. Wait for skillchain partner.
    if scPartner:getLocalVar('scStep') ~= 1 and scStep == 0 then
        mob:setLocalVar('scStep', 1)
        mob:messageText(mob, messages.TP_READY)

    -- We were waiting for the skillchain partner to get TP and now she has it. Start skillchain.
    elseif scPartner:getLocalVar('hasTP') > 0 and scStep == 1 then
        local now           = GetSystemTime()
        local firstWsDelay  = math.random(1, 2)
        local secondWsDelay = math.random(7, 8)

        mob:setMagicCastingEnabled(false)
        mob:setLocalVar('wsTime', now + firstWsDelay)

        scPartner:setMagicCastingEnabled(false)
        scPartner:setLocalVar('scStep', 2)
        scPartner:setLocalVar('wsTime', now + secondWsDelay)
    end
end

-----------------------------------
-- Primary battle loop.
-----------------------------------
local battleController = function(mob, target, scPartner)
    -- Solo weaponskill behavior.
    if not isPrimedForSkillchain(mob, target, scPartner) then
        mob:setMagicCastingEnabled(true)
        return
    end

    local wsTime = mob:getLocalVar('wsTime')
    local scStep = mob:getLocalVar('scStep')
    local now    = GetSystemTime()

    -- Prepare skillchain logistics.
    if wsTime == 0 then
        skillchainHandler(mob, scPartner, scStep)
        return
    end

    -- Try to execute a weaponskill if the skillchain has been decided.
    -- Add blocks to avoid weaponskill / chat spam.
    -- Weaponskill chat will be sent even if action is blocked (like sleeping).
    if now >= wsTime then
        if mob:getLocalVar('chatBlock') == 0 then
            mob:setLocalVar('chatBlock', 1)

            if scStep == 1 then
                mob:messageText(mob, messages.BEGIN_SKILLCHAIN)
            elseif scStep == 2 then
                mob:messageText(mob, messages.CLOSE_SKILLCHAIN)
            end
        end

        if mob:getLocalVar('wsBlock') == 0 then
            if mob:canUseAbilities() then
                mob:setLocalVar('wsBlock', 1)
                mob:useMobAbility(weaponskills[scStep], target)
            end
        end
    end
end

-----------------------------------
-- Sets initial mob-specific immunities.
-- Zero the skill list to prevent solo weaponskilling while another Shikaree is able to skillchain.
-----------------------------------
entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 2, 'Shikaree_Xs_Rabbit')
    -- Regain from mob_pool_mods.sql
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
end

-----------------------------------
-- Initialize local mob variables.
-----------------------------------
entity.onMobSpawn = function(mob)
    skillchainReset(mob)
end

-----------------------------------
-- Primary battle controller.
-----------------------------------
entity.onMobFight = function(mob, target)
    local scPartner = GetMobByID(mob:getID() - 1)
    battleController(mob, target, scPartner)
end

-----------------------------------
-- Solo weaponskill messages.
-----------------------------------
entity.onMobMobskillChoose = function(mob, target)
    if mob:getLocalVar('scStep') == 0 then
        mob:messageText(mob, messages.SOLO_WEAPONSKILL)
    end
end

-----------------------------------
-- Skill messages.
-----------------------------------
entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()

    if skillID == xi.mobSkill.FAMILIAR_1 then
        mob:messageText(mob, messages.USE_TWO_HOUR)
    elseif skillID == xi.mobSkill.CALL_BEAST then
        mob:messageText(mob, messages.CALL_BEAST)
    else
        skillchainReset(mob)
    end
end

-----------------------------------
-- Death message.
-----------------------------------
entity.onMobDeath = function(mob, player, optParams)
    mob:messageText(mob, messages.DEATH)
end

return entity
