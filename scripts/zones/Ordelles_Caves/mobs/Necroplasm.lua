-----------------------------------
-- Area: Ordelle's Caves
--   NM: Necroplasm
-- Involved in Eco Warrior (San d'Oria)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
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

entity.onMobDeath = function(mob, player, optParams)
    if
        player:getCharVar('EcoStatus') == 1 and
        player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION)
    then
        player:setCharVar('EcoStatus', 2)
    end
end

return entity
