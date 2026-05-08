-----------------------------------
-- Area: Navukgo Execution Chamber
--  Mob: Shamarhaan
-----------------------------------
local ID = zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER]
-----------------------------------
---@type TMobEntity
local entity = {}

local function tauntPlayer(player, mob)
    if player:getLevelCap() >= 75 then
        mob:messageText(mob, ID.text.SHAMARHAAN_AUTOMATON_POWER)
    else
        mob:messageText(mob, ID.text.SHAMARHAAN_LET_US_BEGIN)
    end

    mob:setLocalVar('initialTaunt', 1)
    mob:setLocalVar('talkTime', GetSystemTime() + 300)
end

entity.onMobInitialize = function(mob)
    mob:addListener('TAKE_DAMAGE', 'SHAMARHAAN_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        if damage >= 350 then
            mob:messageText(mob, ID.text.SHAMARHAAN_UNDERESTIMATED)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)

    -- Reset mob.
    xi.combat.behavior.enableAllActions(mob)
    mob:setLocalVar('[2hour]HPP', math.random(60, 90))
    mob:setLocalVar('[2hour]Used', 0)
    mob:setLocalVar('initialTaunt', 0)
    mob:setLocalVar('talkTime', 0)
    mob:setLocalVar('alreadyTalked', 0)
    mob:setLocalVar('maneuverUseTime', 0)
    mob:setLocalVar('maneuverNextTimer', math.random(45, 60))
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

    if players[1]:checkDistance(mob) >= 15 then
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
        mob:showText(mob, ID.text.SHAMARHAAN_MAGNIFICENT)
        players[1]:disengage()
        battlefield:win()
        return
    end

    -- Early return: Mob is busy.
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local mobID = mob:getID()
    -- 2 hour if Valkeng is below 50% HP
    if
        mob:getLocalVar('[2hour]Used') == 0 and
        GetMobByID(mobID + 1):isAlive() and
        GetMobByID(mobID + 1):getHPP() < 50
    then
        mob:setLocalVar('[2hour]Used', 1)
        mob:useMobAbility(xi.mobSkill.OVERDRIVE_SHAMARHAAN)
        return
    end

    -- 2 Hour.
    if
        mob:getLocalVar('[2hour]Used') == 0 and
        mobHPP < mob:getLocalVar('[2hour]HPP')
    then
        mob:setLocalVar('[2hour]Used', 1)
        mob:useMobAbility(xi.mobSkill.OVERDRIVE_SHAMARHAAN)
        return
    end

    -- Midfight rage.
    local currentTime = GetSystemTime()
    if
        mob:getLocalVar('alreadyTalked') == 0 and
        currentTime >= mob:getLocalVar('talkTime')
    then
        mob:setLocalVar('alreadyTalked', 1)
        mob:showText(mob, ID.text.SHAMARHAAN_ENOUGH)
        mob:setTP(3000)
        return
    end

    -- Handle Maneuvers.
    local timer = mob:getLocalVar('maneuverNextTimer')
    if currentTime > mob:getLocalVar('maneuverUseTime') + timer then
        mob:useMobAbility(math.random(xi.mobSkill.FIRE_MANEUVER, xi.mobSkill.WATER_MANEUVER))
        mob:setLocalVar('maneuverUseTime', currentTime)
        mob:setLocalVar('maneuverNextTimer', math.random(45, 60))
        return
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local tpTable =
    {
        xi.mobSkill.COMBO_1,
        xi.mobSkill.SHOULDER_TACKLE_1,
        xi.mobSkill.ONE_INCH_PUNCH_1,
        xi.mobSkill.BACKHAND_BLOW_1,
        xi.mobSkill.RAGING_FISTS_1,
        xi.mobSkill.SPINNING_ATTACK_1,
        xi.mobSkill.HOWLING_FIST_1,
    }

    return tpTable[math.random(1, #tpTable)]
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillTable =
    {
        [xi.mobSkill.OVERDRIVE_SHAMARHAAN] = ID.text.SHAMARHAAN_FULL_STEAM,
        [xi.mobSkill.EARTH_MANEUVER      ] = ID.text.SHAMARHAAN_LETS_TRY,
        [xi.mobSkill.WATER_MANEUVER      ] = ID.text.SHAMARHAAN_LETS_TRY,
        [xi.mobSkill.WIND_MANEUVER       ] = ID.text.SHAMARHAAN_LETS_TRY,
        [xi.mobSkill.FIRE_MANEUVER       ] = ID.text.SHAMARHAAN_LETS_TRY,
        [xi.mobSkill.ICE_MANEUVER        ] = ID.text.SHAMARHAAN_LETS_TRY,
        [xi.mobSkill.THUNDER_MANEUVER    ] = ID.text.SHAMARHAAN_LETS_TRY,
    }

    local messageId = skillTable[skill:getID()]
    if messageId then
        action:setCategory(xi.action.category.JOBABILITY_FINISH)
        mob:messageText(mob, messageId)
        return
    end

    if mob:isEngaged() then
        mob:showText(mob, ID.text.SHAMARHAAN_GOT_TRICKS)
    end
end

entity.onMobDisengage = function(mob)
    mob:showText(mob, ID.text.SHAMARHAAN_NOT_READY)
end

return entity
