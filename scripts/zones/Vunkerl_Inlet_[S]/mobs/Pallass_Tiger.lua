-----------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Pallass Tiger
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setLink(0)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 25,
        effectId = xi.effect.PARALYSIS,
        power    = 20,
        duration = 30,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

return entity
