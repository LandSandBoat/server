--[[
Morbol family variant found in ToAU.
Default parameters can be modified by calling xi.mix.uragnite.config(mob, params) from within onMobSpawn.

Config parameters:
    nightRoaming : whether the mob roams at night from 20:00 to 05:00 (default: 0)
    regenPercent : % of max HP to regenerate while within spawn area (default: 1)
    drainPercent : % of target's max HP drained on auto-attack when outside spawn area (default: 1)

Example usage:
entity.onMobSpawn = function(mob)
    xi.mix.toau_morbol.config(mob, {
        nightRoaming = 1,
        regenPercent = 5,
        drainPercent = 10,
    })
end
]]

require('scripts/globals/mixins')

xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.toau_morbol = xi.mix.toau_morbol or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function isWithinArea(mob)
    -- check if mob is within 25 yalms of its spawn point
    return utils.distanceWithin(mob:getPos(), mob:getSpawnPos(), 25, false)
end

xi.mix.toau_morbol.config = function(mob, params)
    if params.nightRoaming and type(params.nightRoaming) == 'number' then
        mob:setLocalVar('[morbolToAU]nightRoaming', params.nightRoaming)
    end

    if params.regenPercent and type(params.regenPercent) == 'number' then
        mob:setLocalVar('[morbolToAU]regenPercent', params.regenPercent)
    end

    if params.drainPercent and type(params.drainPercent) == 'number' then
        mob:setLocalVar('[morbolToAU]drainPercent', params.drainPercent)
    end
end

g_mixins.families.morbol_toau = function(morbolToAUMob)
    -- assign default values on prespawn
    morbolToAUMob:addListener('PRESPAWN', 'MORBOL_TOAU_PRESPAWN', function(mob)
        xi.mix.toau_morbol.config(mob, {
            nightRoaming = 0,
            regenPercent = 1,
            drainPercent = 1,
        })
    end)

    -- unless defined otherwise, mob does not roam from 20:00 to 05:00, unless away from its spawn point
    morbolToAUMob:addListener('ROAM_TICK', 'MORBOL_TOAU_ROAM_TICK', function(mob)
        if mob:getLocalVar('[morbolToAU]nightRoaming') ~= 1 then
            local vanaHour    = VanadielHour()
            local mobModValue = 0

            if
                isWithinArea(mob) and
                (vanaHour >= 20 or vanaHour < 5) -- Is night.
            then
                mobModValue = 1
            end

            mob:setMobMod(xi.mobMod.NO_MOVE, mobModValue)
        end
    end)

    -- will move when engaged
    morbolToAUMob:addListener('ENGAGE', 'MORBOL_TOAU_ENGAGE', function(mob, target)
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    end)

    -- mob regens a % of its maximum hp when inside its spawn area
    morbolToAUMob:addListener('COMBAT_TICK', 'MORBOL_TOAU_COMBAT_TICK', function(mob)
        local regenVar     = mob:getLocalVar('[morbolToAU]regenPercent') / 100
        local regenPercent = regenVar > 0 and regenVar or 0.01
        local regenPotency = isWithinArea(mob) and math.floor(mob:getMaxHP() * regenPercent) or 0

        mob:setMod(xi.mod.REGEN, regenPotency)
    end)

    -- auto-attacks have a fixed % of target's max hp drain when outside of its spawn area
    morbolToAUMob:addListener('ATTACK', 'MORBOL_TOAU_ATTACK', function(attacker, target, action)
        local targetID  = target:getID()
        local actionMsg = action:getMsg(targetID)

        if
            not isWithinArea(attacker) and
            (actionMsg == xi.msg.basic.HIT_DMG or actionMsg == xi.msg.basic.HIT_CRIT)
        then
            local drainVar     = attacker:getLocalVar('[morbolToAU]drainPercent') / 100
            local drainPercent = drainVar > 0 and drainVar or 0.01
            local drainPotency = math.floor(target:getMaxHP() * drainPercent)

            drainPotency = utils.stoneskin(target, drainPotency)

            action:additionalEffect(targetID, xi.subEffect.HP_DRAIN)
            action:addEffectMessage(targetID, xi.msg.basic.ADD_EFFECT_HP_DRAIN)
            action:addEffectParam(targetID, drainPotency)

            target:delHP(drainPotency)
            attacker:addHP(drainPotency)
        end
    end)
end

return g_mixins.families.morbol_toau
