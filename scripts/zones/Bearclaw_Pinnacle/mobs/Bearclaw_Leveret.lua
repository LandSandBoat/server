---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DESPAWN_TIME_REDUCTION, 15)
    mob:setLocalVar('bloodWeaponUsed', 0)
end

-- If the "real" Bearclaw Leveret is below 35% HP, use Blood Weapon
entity.onMobFight = function(mob, target)
    if
        mob:getLocalVar('chosenLeveret') == 1 and
        mob:getLocalVar('bloodWeaponUsed') == 0 and
        mob:getHPP() <= 35
    then
        mob:setLocalVar('bloodWeaponUsed', 1)
        mob:useMobAbility(xi.mobSkill.BLOOD_WEAPON_1)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skills =
    {
        xi.mobSkill.FOOT_KICK_1,
        xi.mobSkill.WHIRL_CLAWS_1,
        xi.mobSkill.SNOW_CLOUD_1,
        xi.mobSkill.WILD_CARROT_1,
    }

    return skills[math.randomInt(1, #skills)]
end

-- The "real" Bearclaw Leveret has a small chance to proc enblizzard damage on hit, revealing itself to players
entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 5,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.ICE,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

-- When a Bearclaw Leveret dies, if it is the "real" one, kill the others
entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        if mob:getLocalVar('chosenLeveret') == 1 then
            local battlefield = mob:getBattlefield()

            if not battlefield then
                return
            end

            local baseId = battlefield:getLocalVar('baseId')

            for i = 1, 5 do
                local bearclawLeveret = GetMobByID(baseId + i)
                if bearclawLeveret and bearclawLeveret:isAlive() then
                    -- They actually "die" and are not just "despawned", they fall over like they die in my capture.
                    bearclawLeveret:setHP(0)
                end
            end
        end
    end
end

return entity
