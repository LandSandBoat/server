-----------------------------------
-- Citadel Buster
-- Deals extreme Light damage to players in an area of effect.
-- Additional effect: Enmity reset
-- Damage can be approximated based on Calculating Weapon Skill Damage as a magical WS with a level of 85, fTP of 6 and MAB of 4.0. Or, more simply:
-- 2088/(1+MDB%) * (256-MDT)/256 (no day/weather bonus)
-- 2608/MDB * (256-MDT)/256 (weather bonus)
-- 2816/MDB * (256-MDT)/256 (day+weather bonus)
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
local ID = require("scripts/zones/Temenos/IDs")

-----------------------------------
local mobskill_object = {}

local citadelBusterTimers =
{
    [0] = 0,
    [1] = 10000,
    [2] = 10000,
    [3] = 5000,
    [4] = 1000,
    [5] = 1000,
    [6] = 1000,
    [7] = 1000,
    [8] = 1000,
    [9] = 500,
}

local function sendMessageToList(playerList, messageID)
    for _, member in pairs(playerList) do
        member:messageSpecial(messageID)
    end
end

local executeCitadelBusterState
executeCitadelBusterState = function(mob)
    local state = mob:getLocalVar("citadelBusterState")
    local battlefield = mob:getBattlefield()
    local players = battlefield:getPlayers()

    -- Message-only states
    if state < 8 then
        sendMessageToList(players, ID.text.CITADEL_BASE + state)
    elseif state == 8 then
        mob:useMobAbility(1540)
    else
        mob:setLocalVar("citadelBuster", 0)
        mob:setLocalVar("citadelBusterState", 0)
        mob:SetMagicCastingEnabled(true)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:setMobMod(xi.mobMod.DRAW_IN, 0)
        return
    end

    state = state + 1
    mob:setLocalVar("citadelBusterState", state)
    mob:timer(citadelBusterTimers[state], function(mobArg)
        executeCitadelBusterState(mobArg)
    end)
end

mobskill_object.onMobSkillCheck = function(target,mob,skill)
    local phase = mob:getLocalVar("battlePhase")
    if phase == 4 then
        mob:setLocalVar("citadelBuster", 1)
        mob:SetMobAbilityEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetAutoAttackEnabled(false)
        mob:setMobMod(xi.mobMod.DRAW_IN, 1)

        executeCitadelBusterState(mob)
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local basedmg = 2088

    if
        mob:getWeather() == xi.weather.AURORAS or
        mob:getWeather() == xi.weather.STELLAR_GLARE
    then
        basedmg = basedmg + 520
    end

    if VanadielDayElement() == xi.magic.ele.LIGHT then
        basedmg = basedmg + 208
    end

    local damage = basedmg / (1 + (target:getMod(xi.mod.MDEF) / 100))
    local dmg = MobFinalAdjustments(damage,mob,skill,target, xi.attackType.MAGICAL, xi.damageType.LIGHT,MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    mob:resetEnmity(target)

    return dmg
end

return mobskill_object
