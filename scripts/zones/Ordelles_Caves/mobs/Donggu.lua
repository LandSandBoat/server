-----------------------------------
-- Area: Ordelle's Caves
--   NM: Donggu
-----------------------------------
local ID = zones[xi.zone.ORDELLES_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -48.060, y =  31.996, z =  270.290 }
}

entity.phList =
{
    [ID.mob.DONGGU - 4] = ID.mob.DONGGU,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 5)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 25,
        effectId = xi.effect.BLINDNESS,
        power    = 20,
        duration = 60,
    }

    return xi.combat.action.executeAdditionalStatus(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 181)
    xi.magian.onMobDeath(mob, player, optParams, set{ 514 })
end

return entity
