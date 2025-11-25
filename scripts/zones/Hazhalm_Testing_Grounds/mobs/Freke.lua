-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Freke (Einherjar)
-- Notes: Immune to Silence for some reason.
-- Below 25%: Uses 5x Lava Spit before GoH.
-----------------------------------
mixins =
{
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

local function notBusy(mob)
    local action = mob:getCurrentAction()
    if
        action == xi.action.category.MOBABILITY_START or
        action == xi.action.category.MOBABILITY_USING or
        action == xi.action.category.MOBABILITY_FINISH
    then
        return false
    end

    return true
end

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('gohSequence', 0)
end

entity.onMobMobskillChoose = function(mob, target)
    local gohSequence = mob:getLocalVar('gohSequence')

    if gohSequence == 1 then
        return xi.mobSkill.GATES_OF_HADES
    elseif gohSequence ~= 0 then
        return xi.mobSkill.LAVA_SPIT
    end

    if mob:getHPP() < 25 then
        -- 16.67% (1/6 possible TP moves) chance to start a GoH sequence
        if math.random(1, 10000) <= 1667 then
            mob:setLocalVar('gohSequence', 6)
            return xi.mobSkill.LAVA_SPIT
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local gohSequence = mob:getLocalVar('gohSequence')
    if gohSequence ~= 0 then
        if gohSequence > 1 and skill:getID() == xi.mobSkill.LAVA_SPIT then
            mob:setLocalVar('gohSequence', gohSequence - 1)
            mob:setAutoAttackEnabled(false)
        elseif skill:getID() == xi.mobSkill.GATES_OF_HADES then
            mob:setLocalVar('gohSequence', 0)
            mob:setAutoAttackEnabled(true)
        end
    end
end

entity.onMobFight = function(mob, target)
    if notBusy(mob) and mob:getLocalVar('gohSequence') ~= 0 then
        mob:setTP(3000)
    end
end

return entity
