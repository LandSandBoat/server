-----------------------------------
-- Area: Batallia Downs
--   NM: Eyegouger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  177.300, y = -2.100, z = -54.540 }
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 25,
        effectId = xi.effect.BLINDNESS,
        power    = 20,
        duration = 60,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 163)
end

return entity
