-----------------------------------
-- Area: Balga's Dais
--  Mob: Maat (Summoner)
-- Genkai 5 Fight
-----------------------------------
local ID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------
---@type TMobEntity
local entity = {}

local callPetParams =
{
    callPetJob   = xi.job.SMN,
    inactiveTime = 3000,
    superLink    = true,
    dieWithOwner = true,
    maxSpawns    = 1,
}

local function tauntPlayer(player, mob)
    mob:messageText(mob, ID.text.YOU_DECIDED_TO_SHOW_UP)
    mob:setLocalVar('initialTaunt', 1)
end

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Maats_Avatar')

    mob:addListener('TAKE_DAMAGE', 'MAAT_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        if damage >= 150 then
            mob:messageText(mob, ID.text.THAT_LL_HURT_IN_THE_MORNING)
        end

        if damage >= 300 then
            mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:setBaseSpeed(60)

    -- Reset mob.
    xi.combat.behavior.enableAllActions(mob)
    mob:setLocalVar('[2hour]HPP', math.random(50, 55))
    mob:setLocalVar('[2hour]Used', 0)
    mob:setLocalVar('initialTaunt', 0)
    mob:setLocalVar('enrageTime', 0)
    mob:setLocalVar('finalWord', 0)
    mob:setLocalVar('alreadyEnraged', 0)
    mob:setLocalVar('petSummonTime', 0)

    -- Maat summons his avatar 10 seconds after spawning.
    mob:timer(10000, function(mobArg)
        xi.mob.callPets(mobArg, mobArg:getID() + 1, callPetParams)
    end)
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
    local petId  = mob:getID() + 1
    local pet    = GetMobByID(petId)
    local mobHPP = mob:getHPP()
    if
        mobHPP < 20 and
        players[1]:isAlive()
    then
        xi.combat.behavior.disableAllActions(mob)
        xi.combat.behavior.disableAllActions(pet)
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
        mobHPP < mob:getLocalVar('[2hour]HPP') and
        pet and pet:isAlive()
    then
        mob:setLocalVar('[2hour]Used', 1)
        mob:useMobAbility(xi.mobSkill.ASTRAL_FLOW_MAAT)
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

    -- If pet is alive, return.
    if pet and pet:isAlive() then
        return
    end

    -- If it's time to resummon our pet, summon it.
    if GetSystemTime() >= mob:getLocalVar('petSummonTime') then
        xi.mob.callPets(mob, petId, callPetParams)
        mob:stun(5000)
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

    return tpTable[math.random(1, #tpTable)]
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillID = skill:getID()

    if skillID == xi.mobSkill.ASTRAL_FLOW_MAAT then
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

    mob:showText(mob, messageTable[math.random(1, #messageTable)])
end

entity.onMobDisengage = function(mob)
    if mob:getLocalVar('finalWord') == 0 then
        mob:showText(mob, ID.text.LOOKS_LIKE_YOU_WERENT_READY)
    end
end

return entity
