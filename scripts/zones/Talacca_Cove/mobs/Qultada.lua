-----------------------------------
-- Area: Talacca Cove
--  Mob: Qultada
-----------------------------------
local ID = zones[xi.zone.TALACCA_COVE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)

    mob:addListener('TAKE_DAMAGE', 'QULTADA_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        if damage >= 350 then
            mob:messageText(mob, ID.text.QULTADA_HEAT_UP)
        end
    end)

    mob:addListener('ABILITY_USE', 'QULTADA_ABILITY_USE', function(mobArg, target, ability, action)
        local abilityId = ability:getID()
        if
            abilityId == xi.ja.CORSAIRS_ROLL or
            abilityId == xi.ja.DOUBLE_UP
        then
            action:messageID(action:getPrimaryTargetID(), 0)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    -- Reset mob.
    xi.combat.behavior.enableAllActions(mob)
    mob:setLocalVar('[2hour]HPP', math.random(50, 90))
    mob:setLocalVar('[2hour]Used', 0)
    mob:setLocalVar('initialTaunt', 0)
    mob:setLocalVar('talkTime', 0)
    mob:setLocalVar('alreadyTalked', 0)
    mob:setLocalVar('quickdrawUseTime', 0)
    mob:setLocalVar('quickdrawNextTimer', math.random(8, 30))
end

entity.onMobRoam = function(mob)
    -- Early return: Already taunted.
    if mob:getLocalVar('initialTaunt') ~= 0 then
        return
    end

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

    -- Early return: Player is too far away.
    if players[1]:checkDistance(mob) >= 15 then
        return
    end

    mob:setLocalVar('initialTaunt', 1)
    mob:messageText(mob, ID.text.QULTADA_LADY_DESTINY)
    mob:useJobAbility(xi.ja.CORSAIRS_ROLL, mob)

    -- TODO: Dont use timers. Use mob entity functions once they are supported for JAs
    mob:timer(6000, function(mobArg)
        mobArg:useJobAbility(xi.ja.DOUBLE_UP, mob)
        mob:timer(4000, function(mobArgTwo)
            mobArgTwo:messageText(mob, math.random(ID.text.QULTADA_LUCK_OF_CORSAIR, ID.text.QULTADA_CHIPS_ARE_DOWN))
        end)
    end)
end

entity.onMobEngage = function(mob, target)
    -- Early return: Already engaged once.
    local taunt = mob:getLocalVar('initialTaunt')
    if taunt == 2 then
        return
    end

    -- Setup "rage" and quick draw.
    local currentTime = GetSystemTime()
    mob:setLocalVar('talkTime', currentTime + 300)
    mob:setLocalVar('quickdrawUseTime', currentTime)

    -- Engaged at distance.
    if taunt == 0 then
        mob:messageText(mob, ID.text.QULTADA_QUICK_START)
    end

    -- Actual taunt.
    if target:getLevelCap() >= 75 then
        mob:messageText(mob, ID.text.QULTADA_GO_EASY)
    else
        mob:messageText(mob, ID.text.QULTADA_CARDS_DEALT)
    end

    -- Mark as engaged.
    mob:setLocalVar('initialTaunt', 2)
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
        mob:showText(mob, ID.text.QULTADA_NOT_BAD)
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
        mob:useMobAbility(xi.mobSkill.WILD_CARD_QULTADA)
        return
    end

    -- Midfight rage.
    local currentTime = GetSystemTime()
    if
        mob:getLocalVar('alreadyTalked') == 0 and
        currentTime >= mob:getLocalVar('talkTime')
    then
        mob:setLocalVar('alreadyTalked', 1)
        mob:showText(mob, ID.text.QULTADA_TOO_BAD)
        mob:setTP(3000)
        return
    end

    -- Handle Quickdraw.
    local timer = mob:checkDistance(target) >= mob:getMeleeRange(target) and 8 or mob:getLocalVar('quickdrawNextTimer')
    if currentTime > mob:getLocalVar('quickdrawUseTime') + timer then
        mob:useMobAbility(math.random(xi.mobSkill.FIRE_SHOT, xi.mobSkill.DARK_SHOT))
        mob:setLocalVar('quickdrawUseTime', currentTime)
        mob:setLocalVar('quickdrawNextTimer', math.random(8, 60))
        return
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local battlefield = mob:getBattlefield()
    local playerLevel = battlefield and battlefield:getLocalVar('playerLevel') or 99

    local tpTable =
    {
        xi.mobSkill.SHINING_BLADE_1,
        xi.mobSkill.CIRCLE_BLADE_1,
        xi.mobSkill.SPIRITS_WITHIN_1,
        xi.mobSkill.SNIPER_SHOT_1,
        xi.mobSkill.SLUG_SHOT_1,
    }

    if playerLevel <= 74 then
        table.insert(tpTable, xi.mobSkill.SPLIT_SHOT_1)
        table.insert(tpTable, xi.mobSkill.HOT_SHOT_1)
    else
        table.insert(tpTable, xi.mobSkill.SAVAGE_BLADE_1)
        table.insert(tpTable, xi.mobSkill.DETONATOR_1)
    end

    return tpTable[math.random(1, #tpTable)]
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillTable =
    {
        [xi.mobSkill.WILD_CARD_QULTADA] = ID.text.QULTADA_BEHOLD,
        [xi.mobSkill.EARTH_SHOT       ] = ID.text.QULTADA_GET_AWAY,
        [xi.mobSkill.WATER_SHOT       ] = ID.text.QULTADA_GET_AWAY,
        [xi.mobSkill.WIND_SHOT        ] = ID.text.QULTADA_GET_AWAY,
        [xi.mobSkill.FIRE_SHOT        ] = ID.text.QULTADA_GET_AWAY,
        [xi.mobSkill.ICE_SHOT         ] = ID.text.QULTADA_GET_AWAY,
        [xi.mobSkill.THUNDER_SHOT     ] = ID.text.QULTADA_GET_AWAY,
        [xi.mobSkill.LIGHT_SHOT       ] = ID.text.QULTADA_GET_AWAY,
        [xi.mobSkill.DARK_SHOT        ] = ID.text.QULTADA_GET_AWAY,
    }

    local messageId = skillTable[skill:getID()]
    if messageId then
        action:setCategory(xi.action.category.JOBABILITY_FINISH)
        mob:messageText(mob, messageId)
        return
    end

    if mob:isEngaged() then
        local messageTable =
        {
            [1] = ID.text.QULTADA_ANTE_UP,
            [2] = ID.text.QULTADA_TRY_YOUR_LUCK,
        }

        mob:showText(mob, messageTable[math.random(1, #messageTable)])
    end
end

entity.onMobDisengage = function(mob)
    mob:showText(mob, ID.text.QULTADA_BETTER_LUCK)
end

return entity
