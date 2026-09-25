-----------------------------------
-- Area: Western Altepa Desert
--   NM: Dahu
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)

    mob:addListener('WEATHER_CHANGE', 'DAHU_WEATHER_CHANGE', function(mobArg, weather, element)
        if not mobArg:isSpawned() then
            return
        end

        if mobArg:isEngaged() then
            return
        end

        if
            element ~= xi.element.FIRE and
            element ~= xi.element.EARTH
        then
            DespawnMob(mobArg:getID())
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.STORETP, 30)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 100,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.EARTH,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobDisengage = function(mob)
    local weatherElement = xi.data.element.getWeatherElement(mob:getWeather())
    if
        weatherElement ~= xi.element.FIRE and
        weatherElement ~= xi.element.EARTH
    then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 413)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(3600)
end

return entity
