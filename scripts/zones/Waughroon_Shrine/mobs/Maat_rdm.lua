-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Maat (Red Mage)
-- Genkai 5 Fight
-----------------------------------
local ID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------
---@type TMobEntity
local entity = {}

local function tauntPlayer(player, mob)
    mob:messageText(mob, ID.text.YOU_DECIDED_TO_SHOW_UP)
    mob:setLocalVar('initialTaunt', 1)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 8)
    mob:setMod(xi.mod.ENSPELL_DMG_BONUS, 17)

    mob:addListener('TAKE_DAMAGE', 'MAAT_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        if damage >= 200 then
            mobArg:messageText(mobArg, ID.text.THAT_LL_HURT_IN_THE_MORNING)
        end

        if damage >= 400 then
            mobArg:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 125)
    mob:setUnkillable(true)
    mob:setBaseSpeed(60)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 7)
    mob:setMod(xi.mod.GRAVITY_MEVA, 100) -- RDM Maat needs Grav Res Rank 7
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 3)

    -- Reset mob.
    xi.combat.behavior.enableAllActions(mob)
    mob:setLocalVar('[2hour]HPP', math.randomInt(55, 60))
    mob:setLocalVar('[2hour]Used', 0)
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
        [ 1] = { xi.magic.spell.CURE_IV,     mob,    false, xi.action.type.HEALING_FORCE_SELF,   33,                  0, 100 },
        [ 2] = { xi.magic.spell.PROTECT_IV,  mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.PROTECT,   4, 100 },
        [ 3] = { xi.magic.spell.SHELL_IV,    mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.SHELL,     4, 100 },
        [ 4] = { xi.magic.spell.STONE_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 5] = { xi.magic.spell.WATER_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 6] = { xi.magic.spell.AERO_III,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 7] = { xi.magic.spell.FIRE_II,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 8] = { xi.magic.spell.BLIZZARD_II, target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 9] = { xi.magic.spell.THUNDER_II,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [10] = { xi.magic.spell.BIO_II,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,       2, 100 },
        [11] = { xi.magic.spell.HASTE,       mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.HASTE,     0, 100 },
        [12] = { xi.magic.spell.STONESKIN,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN, 0, 100 },
        [13] = { xi.magic.spell.AQUAVEIL,    mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.AQUAVEIL,  0, 100 },
        [14] = { xi.magic.spell.BLINK,       mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLINK,     0, 100 },
        [15] = { xi.magic.spell.REGEN,       mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.REGEN,     1, 100 },
        [16] = { xi.magic.spell.ENWATER,     mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ENWATER,   1, 100 },
        [17] = { xi.magic.spell.BIND,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,      0, 100 },
        [18] = { xi.magic.spell.BLIND,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS, 1, 100 },
        [19] = { xi.magic.spell.SILENCE,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SILENCE,   0, 100 },
        [20] = { xi.magic.spell.PARALYZE,    target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.PARALYSIS, 1, 100 },
        [21] = { xi.magic.spell.SLOW,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLOW,      1, 100 },
        [22] = { xi.magic.spell.DIA_II,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DIA,       2, 100 },
        [23] = { xi.magic.spell.DIAGA_II,    target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DIA,       2, 100 },
        [24] = { xi.magic.spell.POISON_II,   target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,    2, 100 },
        [25] = { xi.magic.spell.GRAVITY,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.WEIGHT,    0, 100 },
    }

    if
        target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) and
        mob:isEngaged()
    then
        table.insert(spellList, #spellList + 1, { xi.magic.spell.DISPEL, target, false, xi.action.type.NONE, nil, 100 })
    end

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
        mob:useMobAbility(xi.mobSkill.CHAINSPELL_MAAT)
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

    if skillID == xi.mobSkill.CHAINSPELL_MAAT then
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
