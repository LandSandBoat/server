-----------------------------------
-- Area: Mount Zhayolm
--   NM: Energetic Eruca
-- !pos 176.743 -14.210 -180.926 61
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
---@type TMobEntity
local entity = {}

local function handleRegain(mob)
    local dayElement = VanadielDayElement()
    local regain     = mob:getMod(xi.mod.REGAIN)

    if
        dayElement == xi.element.FIRE and
        regain == 0
    then
        mob:setMod(xi.mod.REGAIN, 30)
    elseif
        dayElement ~= xi.element.FIRE and
        regain ~= 0
    then
        mob:setMod(xi.mod.REGAIN, 0)
    end
end

entity.phList =
{
    -- Verified that there is only one PH
    [ID.mob.ENERGETIC_ERUCA - 320] = ID.mob.ENERGETIC_ERUCA, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLASH_SDT, -10000) -- Immune to slashing damage
end

entity.onMobRoam = function(mob)
    handleRegain(mob)
end

entity.onMobFight = function(mob, target)
    handleRegain(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 455)
end

return entity
