-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Maat (Ninja)
-- Genkai 5 Fight
-----------------------------------
local ID = zones[xi.zone.CHAMBER_OF_ORACLES]
-----------------------------------
---@type TMobEntity
local entity = {}

local function tauntPlayer(player, mob)
    mob:messageText(mob, ID.text.YOU_DECIDED_TO_SHOW_UP)
    mob:setLocalVar('initialTaunt', 1)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.DUAL_WIELD, 1)

    mob:addListener('ABILITY_TAKE', 'MAAT_MIJIN_TAKE', function(user, target, ability, action)
        local abilityId = ability:getID()
        local battlefield = target:getBattlefield()
        if abilityId == xi.jobAbility.MIJIN_GAKURE then
            if target:getHPP() <= 20 then
                xi.combat.behavior.disableAllActions(target)
                target:showText(target, ID.text.YOUVE_COME_A_LONG_WAY)
                battlefield:win()
            end
        end
    end)

    mob:addListener('TAKE_DAMAGE', 'MAAT_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        if damage >= 200 then
            mobArg:messageText(mobArg, ID.text.THAT_LL_HURT_IN_THE_MORNING)
        end

        if damage >= 400 then
            mobArg:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:setBaseSpeed(60)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 125)
    mob:castSpell(xi.magic.spell.UTSUSEMI_NI, mob)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)

    -- Reset mob.
    xi.combat.behavior.enableAllActions(mob)
    mob:setLocalVar('[2hour]HPP', math.randomInt(30, 35))
    mob:setLocalVar('[2hour]Used', 0)
    mob:setLocalVar('initialTaunt', 0)
    mob:setLocalVar('enrageTime', 0)
    mob:setLocalVar('alreadyEnraged', 0)
    mob:setLocalVar('finalWord', 0)
end

entity.onMobRoam = function(mob)
    if mob:getLocalVar('initialTaunt') == 1 then
        return
    end

    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local players = battlefield:getPlayers()
    if not players[1] then
        return
    end

    if players[1]:checkDistance(mob) >= 8 then
        return
    end

    tauntPlayer(players[1], mob)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('enrageTime', GetSystemTime() + 300)

    if mob:getLocalVar('initialTaunt') == 1 then
        return
    end

    tauntPlayer(target, mob)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.UTSUSEMI_NI, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.COPY_IMAGE, 2, 100 },
        [ 2] = { xi.magic.spell.JUBAKU_NI,   target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.PARALYSIS,  2, 100 },
        [ 3] = { xi.magic.spell.DOKUMORI_NI, target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,     2, 100 },
        [ 4] = { xi.magic.spell.KURAYAMI_NI, target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,  2, 100 },
        [ 5] = { xi.magic.spell.KATON_NI,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 66  },
        [ 6] = { xi.magic.spell.HYOTON_NI,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 66  },
        [ 7] = { xi.magic.spell.HUTON_NI,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 66  },
        [ 8] = { xi.magic.spell.DOTON_NI,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 66  },
        [ 9] = { xi.magic.spell.RAITON_NI,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 66  },
        [10] = { xi.magic.spell.SUITON_NI,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 66  },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobFight = function(mob, target)
    -- Early return: No battlefield.
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- Early return: No player.
    local players = battlefield:getPlayers()
    if not players[1] then
        return
    end

    -- Early return: Battle is over.
    if battlefield:getStatus() == xi.battlefield.status.WON then
        return
    end

    -- Win condition.
    local mobHPP = mob:getHPP()
    if
        mobHPP < 20 and
        players[1]:isAlive()
    then
        xi.combat.behavior.disableAllActions(mob)
        mob:showText(mob, ID.text.YOUVE_COME_A_LONG_WAY)
        players[1]:addTitle(xi.title.MAAT_MASHER)
        players[1]:disengage()
        battlefield:win()
    end

    -- Early return: Mob is busy.
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- 2 Hour.
    if
        mob:getLocalVar('[2hour]Used') == 0 and
        mobHPP < mob:getLocalVar('[2hour]HPP')
    then
        mob:setLocalVar('[2hour]Used', 1)
        mob:useMobAbility(xi.mobSkill.MIJIN_GAKURE_MAAT)
        return
    end

    -- Midfight rage.
    if
        mob:getLocalVar('alreadyEnraged') == 0 and
        GetSystemTime() >= mob:getLocalVar('enrageTime')
    then
        mob:setLocalVar('alreadyEnraged', 1)
        mob:setMod(xi.mod.REGAIN, 3000)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    if mob:getLocalVar('alreadyEnraged') == 1 then
        return xi.mobSkill.ASURAN_FISTS_MAAT
    end

    local tpTable =
    {
        xi.mobSkill.COMBO_MAAT,
        xi.mobSkill.TACKLE_MAAT,
        xi.mobSkill.ONE_ILM_PUNCH_MAAT,
        xi.mobSkill.BACKHAND_BLOW_MAAT,
        xi.mobSkill.SPINNING_ATTACK_MAAT,
        xi.mobSkill.HOWLING_FIST_MAAT,
        xi.mobSkill.DRAGON_KICK_MAAT,
    }

    return tpTable[math.randomInt(1, #tpTable)]
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillID = skill:getID()

    if skillID == xi.mobSkill.MIJIN_GAKURE_MAAT then
        mob:showText(mob, ID.text.NOW_THAT_IM_WARMED_UP)
        return
    end

    if
        skillID == xi.mobSkill.ASURAN_FISTS_MAAT and
        mob:getLocalVar('finalWord') == 0
    then
        mob:showText(mob, ID.text.LOOKS_LIKE_YOU_WERENT_READY)
        mob:setLocalVar('finalWord', 1)
    end

    if mob:getLocalVar('alreadyEnraged') == 1 then
        return
    end

    local messageTable =
    {
        [1] = ID.text.TEACH_YOU_TO_RESPECT_ELDERS,
        [2] = ID.text.TAKE_THAT_YOU_WHIPPERSNAPPER,
    }

    mob:showText(mob, messageTable[math.randomInt(1, #messageTable)])
end

entity.onMobDisengage = function(mob)
    if mob:getLocalVar('finalWord') == 0 then
        mob:showText(mob, ID.text.LOOKS_LIKE_YOU_WERENT_READY)
    end
end

return entity
