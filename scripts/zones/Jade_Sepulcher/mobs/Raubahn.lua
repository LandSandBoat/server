-----------------------------------
-- Area: Jade Sepulcher
--   NM: Raubahn
-----------------------------------
local ID = zones[xi.zone.JADE_SEPULCHER]
-----------------------------------
---@type TMobEntity
local entity = {}

local function tauntPlayer(player, mob)
    if player:getLevelCap() >= 75 then -- On retail this message only plays if your cap is exactly 75.
        mob:messageText(mob, ID.text.RAUBAHN_YOUR_SOUL)
    else
        mob:messageText(mob, ID.text.RAUBAHN_COME_SURRENDER)
    end

    mob:setLocalVar('initialTaunt', 1)
    mob:setLocalVar('talkTime', GetSystemTime() + 300)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)

    mob:addListener('TAKE_DAMAGE', 'RAUBAHN_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        if damage >= 400 then -- Raubahn uses some sort of stat copy that isn't fully understood after days of testing.  I think it has to do with taking excessive damage.
            mob:messageText(mob, ID.text.RAUBAHN_GREATER_POWER)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:setMod(xi.mod.DMGMAGIC, -1250) -- Observed at 99 and the skillchain damage in under level 71 vods
    mob:setMod(xi.mod.UFASTCAST, 70)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 8)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 18)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    -- Reset mob.
    xi.combat.behavior.enableAllActions(mob)
    mob:setLocalVar('[2hour]HPP', math.random(50, 90))
    mob:setLocalVar('[2hour]Used', 0)
    mob:setLocalVar('initialTaunt', 0)
    mob:setLocalVar('talkTime', 0)
    mob:setLocalVar('alreadyTalked', 0)
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

    if players[1]:checkDistance(mob) >= 10 then
        return
    end

    tauntPlayer(players[1], mob)
end

entity.onMobEngage = function(mob, target)
    if mob:getLocalVar('initialTaunt') == 1 then
        return
    end

    tauntPlayer(target, mob)
end

entity.onMobSpellChoose = function(mob, target, spell)
    local spellTable =
    {
        [1] = -- 70 and under
        {
            [1] = { xi.magic.spell.COCOON,          mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.DEFENSE_BOOST,   0, 100 },
            [2] = { xi.magic.spell.DIAMONDHIDE,     mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN,       0, 100 },
            [3] = { xi.magic.spell.FEATHER_BARRIER, mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.EVASION_BOOST,   0, 100 },
            [4] = { xi.magic.spell.MEMENTO_MORI,    mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MAGIC_ATK_BOOST, 0, 100 },
            [5] = { xi.magic.spell.REFUELING,       mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.HASTE,           2, 100 },
        },
        [2] =  -- Over 70
        {
            [1] = { xi.magic.spell.AMPLIFICATION,   mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MAGIC_DEF_BOOST, 0, 100 },
            [2] = { xi.magic.spell.COCOON,          mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.DEFENSE_BOOST,   0, 100 },
            [3] = { xi.magic.spell.DIAMONDHIDE,     mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN,       0, 100 },
            [4] = { xi.magic.spell.FEATHER_BARRIER, mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.EVASION_BOOST,   0, 100 },
            [5] = { xi.magic.spell.MEMENTO_MORI,    mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MAGIC_ATK_BOOST, 0, 100 },
            [6] = { xi.magic.spell.REFUELING,       mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.HASTE,           2, 100 },
        },
        [3] = -- 70 and under
        {
            [ 1] = { xi.magic.spell.BLOOD_SABER,    target, false, xi.action.type.DRAIN_HP,           nil,                    0, 100 },
            [ 2] = { xi.magic.spell.BLUDGEON,       target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [ 3] = { xi.magic.spell.FRENETIC_RIP,   target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [ 4] = { xi.magic.spell.FRIGHTFUL_ROAR, target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.DEFENSE_DOWN, 0, 100 },
            [ 5] = { xi.magic.spell.GEIST_WALL,     target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [ 6] = { xi.magic.spell.HEAD_BUTT,      target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [ 7] = { xi.magic.spell.HEALING_BREEZE, mob,    false, xi.action.type.HEALING_FORCE_SELF, 100,                    0, 100 },
            [ 8] = { xi.magic.spell.MAGIC_FRUIT,    mob,    false, xi.action.type.HEALING_FORCE_SELF, 100,                    0, 100 },
            [ 9] = { xi.magic.spell.RADIANT_BREATH, target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [10] = { xi.magic.spell.SMITE_OF_RAGE,  target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [11] = { xi.magic.spell.TAIL_SLAP,      target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
        },
        [4] = -- Over 70
        {
            [ 1] = { xi.magic.spell.BAD_BREATH,       target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [ 2] = { xi.magic.spell.ENERVATION,       target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.DEFENSE_DOWN, 0, 100 },
            [ 3] = { xi.magic.spell.EYES_ON_ME,       target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [ 4] = { xi.magic.spell.FILAMENTED_HOLD,  target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.SLOW,         1, 100 },
            [ 5] = { xi.magic.spell.FROST_BREATH,     target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [ 6] = { xi.magic.spell.HYSTERIC_BARRAGE, target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [ 7] = { xi.magic.spell.MAGIC_FRUIT,      mob,    false, xi.action.type.HEALING_FORCE_SELF, 100,                    0, 100 },
            [ 8] = { xi.magic.spell.SPINAL_CLEAVE,    target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [ 9] = { xi.magic.spell.TAIL_SLAP,        target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [10] = { xi.magic.spell.THOUSAND_NEEDLES, target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [11] = { xi.magic.spell.UPPERCUT,         target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
        },
    }

    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local listIndex = battlefield:getLocalVar('playerLevel') > 70 and 2 or 1
    if mob:isEngaged() then
        listIndex = listIndex + 2
    end

    return xi.combat.behavior.chooseAction(mob, target, nil, spellTable[listIndex])
end

entity.onSpellCastStart = function(mob, target, spell)
    local spellMessage =
    {
        [1] = ID.text.RAUBAHN_BE_BURIED,
        [2] = ID.text.RAUBAHN_SHOW_ME,
    }

    if mob:isEngaged() then
        mob:showText(mob, spellMessage[math.random(1, #spellMessage)])
    end
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
        mob:showText(mob, ID.text.RAUBAHN_STRENGTH_FAILED_ME)
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
        mob:useMobAbility(xi.mobSkill.AZURE_LORE_RAUBAHN)
        return
    end

    -- Midfight rage.
    if
        mob:getLocalVar('alreadyTalked') == 0 and
        GetSystemTime() >= mob:getLocalVar('talkTime')
    then
        mob:setLocalVar('alreadyTalked', 1)
        mob:showText(mob, ID.text.RAUBAHN_IT_IS_OVER)
        mob:setTP(3000)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local battlefield = mob:getBattlefield()
    local playerLevel = battlefield and battlefield:getLocalVar('playerLevel') or 99

    local tpTable =
    {
        xi.mobSkill.RED_LOTUS_BLADE_1,
        xi.mobSkill.FLAT_BLADE_1,
        xi.mobSkill.SERAPH_BLADE_1,
        xi.mobSkill.SPIRITS_WITHIN_1,
    }

    if playerLevel <= 67 then
        table.insert(tpTable, xi.mobSkill.FAST_BLADE_1)
    else
        table.insert(tpTable, xi.mobSkill.SAVAGE_BLADE_1)
    end

    return tpTable[math.random(1, #tpTable)]
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillMessage =
    {
        [xi.mobSkill.FAST_BLADE_1      ] = ID.text.RAUBAHN_OUR_ARSENAL,
        [xi.mobSkill.RED_LOTUS_BLADE_1 ] = ID.text.RAUBAHN_OUR_ARSENAL,
        [xi.mobSkill.FLAT_BLADE_1      ] = ID.text.RAUBAHN_OUR_ARSENAL,
        [xi.mobSkill.SERAPH_BLADE_1    ] = ID.text.RAUBAHN_OUR_ARSENAL,
        [xi.mobSkill.SPIRITS_WITHIN_1  ] = ID.text.RAUBAHN_OUR_ARSENAL,
        [xi.mobSkill.SAVAGE_BLADE_1    ] = ID.text.RAUBAHN_OUR_ARSENAL,
        [xi.mobSkill.AZURE_LORE_RAUBAHN] = ID.text.RAUBAHN_AZURE_SAVEGERY,
    }

    local skillId = skill:getID()
    if skillId == xi.mobSkill.AZURE_LORE_RAUBAHN then
        action:setCategory(xi.action.category.JOBABILITY_FINISH)
    end

    local messageId = skillMessage[skillId]
    if messageId then
        mob:showText(mob, messageId)
    end
end

entity.onMobDisengage = function(mob)
    mob:showText(mob, ID.text.RAUBAHN_BEAST_OF_AMBITION)
end

return entity
