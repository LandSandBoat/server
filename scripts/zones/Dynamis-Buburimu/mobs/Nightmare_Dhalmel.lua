-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Dhalmel
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener('EFFECT_GAIN', 'NIGHTMARE_DHALMEL_BERSERK_GAIN', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.BERSERK then
            mobArg:setDelay(140)
        end
    end)

    mob:addListener('EFFECT_LOSE', 'NIGHTMARE_DHALMEL_BERSERK_LOSE', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.BERSERK then
            mobArg:setDelay(240)
        end
    end)
end

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
    mob:setLocalVar('dynamis_currency', 1449)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.SONIC_WAVE_2,
        xi.mobSkill.STOMPING_2,
        xi.mobSkill.COLD_STARE_2,
        xi.mobSkill.WHISTLE_2,
        xi.mobSkill.BERSERK_DHALMEL_2,
        xi.mobSkill.HEALING_BREEZE_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
