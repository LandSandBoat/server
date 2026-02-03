-----------------------------------
-- Area: Aydeewa Subterrane
--   NM: Lizardtrap
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
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

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 462)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(7200, 7800)) -- 120 to 130 minutes
end

return entity
