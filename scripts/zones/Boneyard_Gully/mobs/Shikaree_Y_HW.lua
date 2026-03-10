-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree Y (Head Wind)
-- BCNM: Head Wind
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.BIND_RES_RANK, 8)
    mob:setMod(xi.mod.REGAIN, 55)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobAbilityEnabled(false)
end

entity.onMobFight = function(mob, target)
    -- Handle "Blackened Siredon" timer and effect.
    local siredonTimer = mob:getLocalVar('siredonTimer')
    if siredonTimer > 0 and GetSystemTime() >= siredonTimer then
        mob:setLocalVar('siredonTimer', 0)
        mob:setMod(xi.mod.REGAIN, 40)
    end

    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- Lock target during skillchain execution (scState 2=STARTING, 3=EXECUTING)
    local scState = battlefield:getLocalVar('scState')
    if scState == 2 or scState == 3 then
        local scLeaderID = battlefield:getLocalVar('scLeader')
        local scLeader = scLeaderID > 0 and GetMobByID(scLeaderID) or nil
        if scLeader and scLeader:isAlive() then
            local leaderTarget = scLeader:getTarget()
            if leaderTarget and leaderTarget:getID() ~= target:getID() then
                mob:updateEnmity(leaderTarget)
            end
        end

    -- Shikaree use TP at 1000 when solo
    elseif scState == 4 and mob:getTP() >= 1000 then
        mob:useMobAbility()
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local tpMoves =
    {
        xi.mobSkill.GUILLOTINE_1,
        xi.mobSkill.VORPAL_SCYTHE,
        xi.mobSkill.SPIRAL_HELL,
    }

    return tpMoves[math.random(1, #tpMoves)]
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillID     = skill:getID()
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    -- 2-Hour message.
    if skillID == xi.mobSkill.BLOOD_WEAPON_1 then
        mob:messageText(mob, ID.text.SHIKAREE_Y_2HR)
        return
    end

    -- Solo skill message when only one Shikaree is alive (scState 4 = SOLO)
    if battlefield:getLocalVar('scState') == 4 then
        mob:messageText(mob, ID.text.SHIKAREE_Y_OFFSET + 4)
        return
    end

    -- Handle skillchain progression
    local scSkill  = mob:getLocalVar('scSkill')
    local scNextID = mob:getLocalVar('scNextID')

    if skillID == scSkill then
        -- Transition from STARTING to EXECUTING when leader's skill fires
        if battlefield:getLocalVar('scState') == 2 then
            battlefield:setLocalVar('scState', 3)
        end

        -- Pull message for either starting SC or using skill mid SC
        local scMessage = mob:getLocalVar('scMessage')
        if scMessage > 0 then
            mob:messageText(mob, scMessage)
        end

        -- Clear this mob's skill tracking
        mob:setLocalVar('scSkill', 0)
        mob:setLocalVar('scPendingTime', 0)

        -- Trigger next mob in chain
        if scNextID > 0 then
            local nextMob = GetMobByID(scNextID)
            if nextMob and nextMob:isAlive() then
                nextMob:setLocalVar('scPendingTime', GetSystemTime() + 3)
            end
        end
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.THUNDER,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 2] = { xi.magic.spell.BLIZZARD,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 3] = { xi.magic.spell.FIRE,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 4] = { xi.magic.spell.AERO,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 5] = { xi.magic.spell.WATER_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 6] = { xi.magic.spell.WATER,      target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 7] = { xi.magic.spell.STONE_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 8] = { xi.magic.spell.STONE,      target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 9] = { xi.magic.spell.POISON,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,   0, 100 },
        [10] = { xi.magic.spell.BIO_II,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,      4, 100 },
        [11] = { xi.magic.spell.ABSORB_TP,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [12] = { xi.magic.spell.ABSORB_STR, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STR_DOWN, 0, 100 },
        [13] = { xi.magic.spell.ABSORB_CHR, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.CHR_DOWN, 0, 100 },
        [14] = { xi.magic.spell.ABSORB_VIT, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.VIT_DOWN, 0, 100 },
        [15] = { xi.magic.spell.ABSORB_DEX, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DEX_DOWN, 0, 100 },
        [16] = { xi.magic.spell.ABSORB_AGI, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.AGI_DOWN, 0, 100 },
        [17] = { xi.magic.spell.ABSORB_INT, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.INT_DOWN, 0, 100 },
        [18] = { xi.magic.spell.ABSORB_MND, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.MND_DOWN, 0, 100 },
        [19] = { xi.magic.spell.DRAIN,      target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [20] = { xi.magic.spell.ASPIR,      target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:messageText(mob, ID.text.SHIKAREE_Y_OFFSET)
end

return entity
