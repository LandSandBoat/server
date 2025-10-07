-- morbol family variant found in ToAU

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function isWithinArea(mob)
    -- check if mob is within 25 yalms of its spawn point
    return utils.distanceWithin(mob:getPos(), mob:getSpawnPos(), 25, false)
end

g_mixins.families.morbol_toau = function(morbolToAUMob)
    -- mob does not roam from 20:00 to 05:00, unless away from its spawn point
    morbolToAUMob:addListener('ROAM_TICK', 'MORBOL_TOAU_ROAM_TICK', function(mob)
        local vanaHour = VanadielHour()
        local isNight = vanaHour >= 20 or vanaHour < 5

        mob:setMobMod(xi.mobMod.NO_MOVE, (isNight and isWithinArea(mob)) and 1 or 0)
    end)

    -- will move when engaged
    morbolToAUMob:addListener('ENGAGE', 'MORBOL_TOAU_ENGAGE', function(mob, target)
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    end)

    -- mob regens 1% of its maximum hp when inside its spawn area
    morbolToAUMob:addListener('COMBAT_TICK', 'MORBOL_TOAU_COMBAT_TICK', function(mob)
        local regenPotency = isWithinArea(mob) and math.floor(mob:getMaxHP() * 0.01) or 0
        mob:setMod(xi.mod.REGEN, regenPotency)
    end)

    -- auto-attacks have a fixed 1% of target's max hp drain when outside of its spawn area
    morbolToAUMob:addListener('ATTACK', 'MORBOL_TOAU_ATTACK', function(attacker, target, action)
        local targetID = target:getID()
        local hasHit =
            action:getMsg(targetID) == xi.msg.basic.HIT_DMG or
            action:getMsg(targetID) == xi.msg.basic.HIT_CRIT

        if not isWithinArea(attacker) and hasHit then
            local hpDrainPower = math.floor(target:getMaxHP() * 0.01)
            hpDrainPower = utils.stoneskin(target, hpDrainPower)

            action:additionalEffect(targetID, xi.subEffect.HP_DRAIN)
            action:addEffectMessage(targetID, xi.msg.basic.ADD_EFFECT_HP_DRAIN)
            action:addEffectParam(targetID, hpDrainPower)

            target:delHP(hpDrainPower)
            attacker:addHP(hpDrainPower)
        end
    end)
end

return g_mixins.families.morbol_toau
