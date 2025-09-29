-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Gladiatorial Weapon
-- BCNM: Die by the Sword
-----------------------------------
local ID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------
---@type TMobEntity
local entity = {}

local weaknessTable =
{
    [1] = -- swords/slashing weakness
    {
        [xi.mod.SLASH_SDT ] =   1000,
        [xi.mod.PIERCE_SDT] = -10000,
        [xi.mod.IMPACT_SDT] = -10000,
    },
    [2] = -- spears/piercing weakness
    {
        [xi.mod.SLASH_SDT ] = -10000,
        [xi.mod.PIERCE_SDT] =   1000,
        [xi.mod.IMPACT_SDT] = -10000,
    },
    [3] = -- clubs/blunt weakness
    {
        [xi.mod.SLASH_SDT ] = -10000,
        [xi.mod.PIERCE_SDT] = -10000,
        [xi.mod.IMPACT_SDT] =   1000,
    },
}

local getNewWeakness = function(mob)
    local currentWeakness = mob:getAnimationSub()
    local newWeakness = 1 + ((currentWeakness + math.random(1, 2)) % 3)

    mob:queue(3000, function(mobArg)
        -- Blood Weapon 2hr animation as captured on retail.
        -- This seems to occur randomly on weakness change; I presume this is due to a glitch.
        -- So we will just trigger it every time a weakness is changed.
        mobArg:injectActionPacket(mob:getID(), 11, 439, 0, 0, 0, 0, 0)

        if newWeakness ~= currentWeakness then
            mobArg:setAnimationSub(newWeakness)

            for mod, value in pairs(weaknessTable[newWeakness]) do
                mobArg:setMod(mod, value)
            end
        else
            mobArg:setAnimationSub(((newWeakness % 3) + 1))

            for mod, value in pairs(weaknessTable[(newWeakness % 3) + 1]) do
                mobArg:setMod(mod, value)
            end
        end
    end)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addMod(xi.mod.UDMGMAGIC, -10000)
end

entity.onMobSpawn = function(mob)
    local mobId = mob:getID()
    local mobOffset = mobId - ID.mob.GLADIATORIAL_WEAPON + 1

    mob:setAnimationSub(mobOffset)
    for mod, value in pairs(weaknessTable[mobOffset]) do
        mob:setMod(mod, value)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    getNewWeakness(mob)
end

return entity
