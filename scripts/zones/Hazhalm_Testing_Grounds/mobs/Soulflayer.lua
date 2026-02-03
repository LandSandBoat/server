-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Soulflayer (Einherjar)
-- Notes: Full immunity to blind and dark sleep
-----------------------------------
mixins = { require('scripts/mixins/families/soulflayer') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobMobskillChoose = function(mob, target)
    local shield = mob:getLocalVar('immortalShieldStacks')
    local tpList =
    {
        xi.mobSkill.MIND_BLAST,
        xi.mobSkill.TRIBULATION,
        xi.mobSkill.IMMORTAL_ANATHEMA,
    }

    -- Add mind purge only if target has dispellable effects
    if target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) then
        table.insert(tpList, xi.mobSkill.MIND_PURGE)
    end

    -- Add immortal shield if below max stacks
    if shield < 2 then
        table.insert(tpList, xi.mobSkill.IMMORTAL_SHIELD)
    end

    -- Add immortal mind if there are 3+ allies within 10 yalms
    local allyCount = 0
    for _, otherMob in pairs(mob:getZone():getMobs()) do
        if
            otherMob:getID() ~= mob:getID() and
            otherMob:isAlive() and
            mob:checkDistance(otherMob) <= 10
        then
            allyCount = allyCount + 1
        end
    end

    if allyCount >= 3 then
        table.insert(tpList, xi.mobSkill.IMMORTAL_MIND)
    end

    return tpList[math.random(1, #tpList)]
end

return entity
