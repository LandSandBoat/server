-----------------------------------
-- Area: Horlais Peak
--  Mob: Maat (Black Mage)
-- Genkai 5 Fight
-----------------------------------
local ID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------
---@type TMobEntity
local entity = {}

local function tauntPlayer(player, mob)
    mob:messageText(mob, ID.text.YOU_DECIDED_TO_SHOW_UP)
    mob:setLocalVar('initialTaunt', 1)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)

    mob:addListener('TAKE_DAMAGE', 'MAAT_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        if damage >= 162 then
            mobArg:messageText(mobArg, ID.text.THAT_LL_HURT_IN_THE_MORNING)
        end

        if damage >= 324 then
            mobArg:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:setBaseSpeed(60)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 125)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)

    -- Reset mob.
    xi.combat.behavior.enableAllActions(mob)
    mob:setLocalVar('[2hour]HPP', math.randomInt(55, 65))
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
        [ 1] = { xi.magic.spell.FIRAGA_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 2] = { xi.magic.spell.AEROGA_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 3] = { xi.magic.spell.WATERGA_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 4] = { xi.magic.spell.STONEGA_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 5] = { xi.magic.spell.THUNDAGA_II,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 6] = { xi.magic.spell.BLIZZAGA_II,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 7] = { xi.magic.spell.BURST,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 8] = { xi.magic.spell.FLOOD,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 9] = { xi.magic.spell.BURN,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BURN,         0,  30 },
        [10] = { xi.magic.spell.SHOCK,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SHOCK,        0,  30 },
        [11] = { xi.magic.spell.DROWN,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DROWN,        0,  30 },
        [12] = { xi.magic.spell.RASP,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.RASP,         0,  30 },
        [13] = { xi.magic.spell.FROST,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FROST,        0,  30 },
        [14] = { xi.magic.spell.CHOKE,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.CHOKE,        0,  30 },
        [15] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLAZE_SPIKES, 0,  30 },
        [16] = { xi.magic.spell.POISONGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,       2,  30 },
        [17] = { xi.magic.spell.BIO_II,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,          2,  30 },
        [18] = { xi.magic.spell.STUN,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.STUN,         0,  30 },
        [19] = { xi.magic.spell.BIND,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,         0,  30 },
        [20] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,    0,  30 },
        [21] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,             nil,                    0,  30 },
        [22] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DRAIN_MP,             nil,                    0,  30 },
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
        players[1]:disengage()
        battlefield:win()
        return
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
        mob:useMobAbility(xi.mobSkill.MANAFONT_MAAT)
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

    if skillID == xi.mobSkill.MANAFONT_MAAT then
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
