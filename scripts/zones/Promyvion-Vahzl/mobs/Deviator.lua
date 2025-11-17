-----------------------------------
-- Area: Promyvion-Vahzl
--   NM: Deviator
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- Spells cast when changing to each element
local elementalSpells =
{
    [xi.element.FIRE   ] = xi.magic.spell.FIRAGA_II,
    [xi.element.ICE    ] = xi.magic.spell.BLIZZAGA_II,
    [xi.element.WIND   ] = xi.magic.spell.AEROGA_II,
    [xi.element.EARTH  ] = xi.magic.spell.STONEGA_II,
    [xi.element.THUNDER] = xi.magic.spell.THUNDAGA_II,
    [xi.element.WATER  ] = xi.magic.spell.WATERGA_II,
    [xi.element.LIGHT  ] = xi.magic.spell.BANISHGA_II,
    [xi.element.DARK   ] = xi.magic.spell.SLEEPGA_II,
}

local eleAbsorbActionID   = { 603, 604, 624, 404, 625, 626, 627, 307 }
local eleAbsorbAnimations = { 432, 433, 434, 435, 436, 437, 438, 439 }

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)

    -- Pick a random element to absorb after engaging
    local currentAbsorb = math.random(xi.element.FIRE, xi.element.DARK)

    mob:setLocalVar('currentAbsorb', currentAbsorb)
    mob:setMod(xi.data.element.getElementalAbsorptionModifier(currentAbsorb), 100)
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
        mob:setMod(xi.data.element.getElementalAbsorptionModifier(currentAbsorb), 100)

        -- Inject 2hr animation based on element
        mob:injectActionPacket(mob:getID(), 11, eleAbsorbAnimations[currentAbsorb], 0x18, 0, 0, eleAbsorbActionID[currentAbsorb], 0)

        -- Cast the corresponding elemental spell
        local spellToCast = elementalSpells[currentAbsorb]
        if spellToCast then
            mob:queue(4000, function(mobArg)
                mobArg:castSpell(spellToCast, target)
            end)
        end
    end
end

return entity
