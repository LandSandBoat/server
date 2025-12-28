-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Logi (Growing) (Einherjar)
-- Notes: Unlike the other Logi, these grow in size before eventually self-destructing.
-- Immune to all immobilizing effects.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobFight = function(mob)
    -- TODO:
    -- Supposed to grow in size as fight progresses
    -- TP moves possibly locked behind size
    -- Self-destructs after several growth
    -- ini1/ini2/ini3 animations
end

return entity
