-----------------------------------
-- Area: Balga's Dais
--  Mob: Maat (White Mage)
-- Genkai 5 Fight
-----------------------------------
local ID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------
---@type TMobEntity
local entity = {}

local function tauntPlayer(player, mob)
    mob:messageText(mob, ID.text.YOU_DECIDED_TO_SHOW_UP)
    mob:setLocalVar('initialTaunt', 1)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 10)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)

    mob:addListener('TAKE_DAMAGE', 'MAAT_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        if damage >= 115 then
            mob:messageText(mob, ID.text.THAT_LL_HURT_IN_THE_MORNING)
        end

        if damage >= 230 then
            mob:setLocalVar('miniEnrage', 1)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:setBaseSpeed(60)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 6)

    -- Reset mob.
    xi.combat.behavior.enableAllActions(mob)
    mob:setLocalVar('[2hour]HPP', math.random(50, 55))
    mob:setLocalVar('[2hour]Used', 0)
    mob:setLocalVar('miniEnrage', 0)
    mob:setLocalVar('initialTaunt', 0)
    mob:setLocalVar('enrageTime', 0)
    mob:setLocalVar('alreadyEnraged', 0)
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
        [ 1] = { xi.magic.spell.CURE_V,       mob,    false, xi.action.type.HEALING_FORCE_SELF,   66,                  0, 100 },
        [ 2] = { xi.magic.spell.PROTECT_IV,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.PROTECT,   4, 100 },
        [ 3] = { xi.magic.spell.SHELL_IV,     mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.SHELL,     3, 100 },
        [ 4] = { xi.magic.spell.BANISHGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 5] = { xi.magic.spell.HOLY,         target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 6] = { xi.magic.spell.FLASH,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FLASH,     0, 100 },
        [ 7] = { xi.magic.spell.HASTE,        mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.HASTE,     0, 100 },
        [ 8] = { xi.magic.spell.STONESKIN,    mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN, 4, 100 },
        [ 9] = { xi.magic.spell.AQUAVEIL,     mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.AQUAVEIL,  4, 100 },
        [10] = { xi.magic.spell.BLINK,        mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLINK,     3, 100 },
        [11] = { xi.magic.spell.PARALYNA,     mob,    true,  xi.action.type.HEALING_EFFECT,       xi.effect.PARALYSIS, 0, 100 },
        [12] = { xi.magic.spell.SILENCE,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SILENCE,   0, 100 },
        [13] = { xi.magic.spell.PARALYZE,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.PARALYSIS, 1, 100 },
        [14] = { xi.magic.spell.SLOW,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLOW,      1, 100 },
        [15] = { xi.magic.spell.DIA_II,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DIA,       2, 100 },
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
    local twoHourUsed = mob:getLocalVar('[2hour]Used')
    if
        twoHourUsed == 0 and
        mobHPP < mob:getLocalVar('[2hour]HPP')
    then
        mob:setLocalVar('[2hour]Used', 1)
        mob:useMobAbility(xi.mobSkill.BENEDICTION_MAAT)
        return
    end

    -- Mini Enrage
    if
        twoHourUsed == 1 and
        mob:getLocalVar('miniEnrage') == 1
    then
        mob:setLocalVar('miniEnrage', 2)
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
        mob:setMod(xi.mod.DEF, 350)
    end

    -- Midfight rage.
    if
        mob:getLocalVar('alreadyEnraged') == 0 and
        GetSystemTime() >= mob:getLocalVar('enrageTime')
    then
        mob:setLocalVar('alreadyEnraged', 1)
        xi.combat.behavior.disableAllActions(mob)
        mob:showText(mob, ID.text.YOUVE_COME_A_LONG_WAY)
        players[1]:disengage()
        battlefield:win()
        return
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
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

    return tpTable[math.random(1, #tpTable)]
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    if skill:getID() == xi.mobSkill.BENEDICTION_MAAT then
        mob:showText(mob, ID.text.NOW_THAT_IM_WARMED_UP)
        return
    end

    if mob:getLocalVar('alreadyEnraged') == 1 then
        return
    end

    local messageTable =
    {
        [1] = ID.text.TEACH_YOU_TO_RESPECT_ELDERS,
        [2] = ID.text.TAKE_THAT_YOU_WHIPPERSNAPPER,
    }

    mob:showText(mob, messageTable[math.random(1, #messageTable)])
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar('enrageTime', 0)
    if mob:getLocalVar('alreadyEnraged') == 0 then
        mob:showText(mob, ID.text.LOOKS_LIKE_YOU_WERENT_READY)
    end
end

return entity
