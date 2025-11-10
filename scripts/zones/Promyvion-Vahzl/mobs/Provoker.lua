-----------------------------------
-- Area: Promyvion - Vahzl
--   NM: Provoker
-----------------------------------
---@type TMobEntity
local entity = {}

local eleAddEffects =
{
    [xi.element.FIRE]    = xi.mob.ae.ENFIRE,
    [xi.element.ICE]     = xi.mob.ae.ENBLIZZARD,
    [xi.element.WIND]    = xi.mob.ae.ENAERO,
    [xi.element.EARTH]   = xi.mob.ae.ENSTONE,
    [xi.element.THUNDER] = xi.mob.ae.ENTHUNDER,
    [xi.element.WATER]   = xi.mob.ae.ENWATER,
    [xi.element.LIGHT]   = xi.mob.ae.ENLIGHT,
    [xi.element.DARK]    = xi.mob.ae.ENDARK,
}

local eleAbsorbActionID   = { 603, 604, 624, 404, 625, 626, 627, 307 }
local eleAbsorbAnimations = { 432, 433, 434, 435, 436, 437, 438, 439 }

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.ACC, 50)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    -- Pick a random element to absorb after engaging
    local currentAbsorb = math.random(xi.element.FIRE, xi.element.DARK)

    mob:setLocalVar('currentAbsorb', currentAbsorb)
    mob:setLocalVar('element', currentAbsorb)
    mob:setMod(xi.data.element.getElementalAbsorptionModifier(currentAbsorb), 100)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 35)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('elementAbsorb', GetSystemTime() + math.random(30, 40))
end

entity.onMobFight = function(mob, target)
    if GetSystemTime() > mob:getLocalVar('elementAbsorb') then

        local previousAbsorb = mob:getLocalVar('currentAbsorb')
        mob:setLocalVar('elementAbsorb', GetSystemTime() + math.random(30, 40))

        -- remove previous absorb mod, if set
        if previousAbsorb > 0 then
            mob:setMod(xi.data.element.getElementalAbsorptionModifier(previousAbsorb), 0)
        end

        -- add new absorb mod
        local currentAbsorb = math.random(xi.element.FIRE, xi.element.DARK)
        mob:setLocalVar('currentAbsorb', currentAbsorb)
        mob:setLocalVar('element', currentAbsorb)
        mob:setMod(xi.data.element.getElementalAbsorptionModifier(currentAbsorb), 100)

        -- Inject 2hr animation based on element
        mob:injectActionPacket(mob:getID(), 11, eleAbsorbAnimations[currentAbsorb], 0x18, 0, 0, eleAbsorbActionID[currentAbsorb], 0)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    local element = mob:getLocalVar('element')
    local additionalEffect = eleAddEffects[element]

    if additionalEffect then
        return xi.mob.onAddEffect(mob, target, damage, additionalEffect, { chance = 1000 })
    else
        return 0, 0, 0 -- Just in case its somehow not got a variable set
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
