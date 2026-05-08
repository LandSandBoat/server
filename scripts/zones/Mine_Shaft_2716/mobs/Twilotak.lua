-----------------------------------
-- Area: Mine Shaft 2716
-- Return to the Depths: Bastok Quest: 1 79
-- NM: Twilotak
-----------------------------------
---@type TMobEntity
local entity = {}

local arenaCenters =
{
    [1] = { x = -459.000, y =  122.032, z = 20.504 },
    [2] = { x =   20.014, y =    2.032, z = 19.936 },
    [3] = { x =  500.000, y = -117.967, z = 19.961 },
}

-----------------------------------
-- Draw In Handler
-----------------------------------
local function handleDrawIn(mob, target, battlefield)
    -- Early return: No battlefield.
    if not battlefield then
        return
    end

    -- Early return: No center.
    local center = arenaCenters[battlefield:getArea()]
    if not center then
        return
    end

    -- Early return: Distance from center check & first wisewoman alive check.
    -- Once the wisewoman on the left is killed, players will no longer be drawn in
    -- TODO: Additional research on draw in mechanics.  It's possible that each add is responsible for draw in on a different player.
    if
        target:checkDistance(center.x, center.y, center.z) <= 15 or
        GetMobByID(mob:getID() + 1):isDead()
    then
        return
    end

    local drawInPosition =
    {
        x   = center.x,
        y   = center.y,
        z   = center.z + 3.0,
        rot = 194,
    }

    -----------------------------------
    -- Draw in all players to the draw in position, skip players already within 15 yalms
    -----------------------------------
    for _, player in pairs(battlefield:getPlayers()) do
        local distanceFromDrawIn = player:checkDistance(drawInPosition.x, drawInPosition.y, drawInPosition.z)
        if distanceFromDrawIn > 15 then
            mob:drawIn(player, 0, 0, drawInPosition)
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.SILENCE)

    mob:addListener('MAGIC_STATE_EXIT', 'MAGIC_EMOTE', function(mobArg, spell)
        mobArg:useMobAbility(xi.mobSkill.MOBLIN_EMOTE_3)
        local mobID = mob:getID()
            for i = 1, 6 do
            local nextMob = GetMobByID(mobID + i)
                if nextMob and nextMob:isAlive() then
                nextMob:useMobAbility(xi.mobSkill.MOBLIN_EMOTE_2)
            end
        end
    end)

    mob:addListener('EFFECT_LOSE', 'BLOOD_WEAPON_EFFECT_LOSE', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.BLOOD_WEAPON then
            mob:setMagicCastingEnabled(true)
            mobArg:setMod(xi.mod.DELAYP, 0)
            mobArg:useMobAbility(xi.mobSkill.MOBLIN_EMOTE_3)
            local mobID = mob:getID()
                for i = 1, 6 do
                local nextMob = GetMobByID(mobID + i)
                    if nextMob and nextMob:isAlive() then
                    nextMob:useMobAbility(xi.mobSkill.MOBLIN_EMOTE_2)
                end
            end
        end
    end)

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'EMOTE_TIME', function(mobArg, skillId, wasExecuted)
        if
            skillId == xi.mobSkill.FRYPAN_1 or
            skillId == xi.mobSkill.SMOKEBOMB_2 or
            skillId == xi.mobSkill.CRISPY_CANDLE_2 or
            skillId == xi.mobSkill.PARALYSIS_SHOWER_2
        then
            mobArg:useMobAbility(xi.mobSkill.MOBLIN_EMOTE_1)
            local mobID = mob:getID()
                for i = 1, 6 do
                local nextMob = GetMobByID(mobID + i)
                    if nextMob and nextMob:isAlive() then
                    nextMob:useMobAbility(xi.mobSkill.MOBLIN_EMOTE_4)
                end
            end
        end

        if
            skillId == xi.mobSkill.GOBLIN_RUSH_2 or
            skillId == xi.mobSkill.SMOKEBOMB_1 or
            skillId == xi.mobSkill.CRISPY_CANDLE_1 or
            skillId == xi.mobSkill.PARALYSIS_SHOWER_1
        then
            mobArg:useMobAbility(xi.mobSkill.MOBLIN_EMOTE_3)
            local mobID = mob:getID()
                for i = 1, 6 do
                local nextMob = GetMobByID(mobID + i)
                    if nextMob and nextMob:isAlive() then
                    nextMob:useMobAbility(xi.mobSkill.MOBLIN_EMOTE_2)
                end
            end
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[2hour]HPP', math.random(75, 85))
    mob:setLocalVar('[2hour]Used', 0)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobFight = function(mob, target)
    -- Check for Draw In
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    handleDrawIn(mob, target, battlefield)

    local currentTime = GetSystemTime()
    -- Handle 2 Hour
    if
        mob:getLocalVar('[2hour]Used') == 0 and
        mob:getHPP() < mob:getLocalVar('[2hour]HPP')
    then
        mob:setLocalVar('[2hour]Used', 1)
        mob:setMagicCastingEnabled(false)
        mob:useMobAbility(xi.mobSkill.BLOOD_WEAPON_1)
        mob:setLocalVar('twoHourTime', currentTime + math.random(120, 180))
        return
    end

    if mob:getLocalVar('twoHourTime') == currentTime then
        mob:setLocalVar('[2hour]Used', 0)
    end
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    if skill:getID() == xi.mobSkill.BLOOD_WEAPON_1 then
        mob:setMod(xi.mod.DELAYP, -25)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    battlefield:win()
end

return entity
