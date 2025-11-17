-----------------------------------
-- Area: Promyvion-Vahzl
--   NM: Wailer
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- TP moves used when changing to each element (Memory of [Element])
local elementalTPMoves =
{
    [xi.element.FIRE]    = xi.mobSkill.MEMORY_OF_FIRE,
    [xi.element.ICE]     = xi.mobSkill.MEMORY_OF_ICE,
    [xi.element.WIND]    = xi.mobSkill.MEMORY_OF_WIND,
    [xi.element.EARTH]   = xi.mobSkill.MEMORY_OF_EARTH,
    [xi.element.THUNDER] = xi.mobSkill.MEMORY_OF_LIGHTNING,
    [xi.element.WATER]   = xi.mobSkill.MEMORY_OF_WATER,
    [xi.element.LIGHT]   = xi.mobSkill.MEMORY_OF_LIGHT,
    [xi.element.DARK]    = xi.mobSkill.MEMORY_OF_DARK,
}

local eleAbsorbActionID   = { 603, 604, 624, 404, 625, 626, 627, 307 }
local eleAbsorbAnimations = { 432, 433, 434, 435, 436, 437, 438, 439 }

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    -- Pick a random element to absorb after engaging
    local currentAbsorb = math.random(xi.element.FIRE, xi.element.DARK)

    mob:setLocalVar('currentAbsorb', currentAbsorb)
    mob:setMod(xi.data.element.getElementalAbsorptionModifier(currentAbsorb), 100)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('elementAbsorb', GetSystemTime() + math.random(30, 40))
end

entity.onMobFight = function(mob, target)
    -- every 30-40 seconds the mob will change the element it absorbs, this change happens after a two hour animation
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
        mob:setMod(xi.data.element.getElementalAbsorptionModifier(currentAbsorb), 100)

        -- Inject 2hr animation based on element
        mob:injectActionPacket(mob:getID(), 11, eleAbsorbAnimations[currentAbsorb], 0x18, 0, 0, eleAbsorbActionID[currentAbsorb], 0)
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    -- Only allow the Memory move that matches the current element
    return elementalTPMoves[mob:getLocalVar('currentAbsorb')]
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
