-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--   NM: Demoiselle Desolee
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -51.734, y = -28.457, z =  686.549 }
}

entity.phList =
{
    [ID.mob.DEMOISELLE_DESOLEE - 4] = ID.mob.DEMOISELLE_DESOLEE, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 25,
        effectId = xi.effect.PARALYSIS,
        power    = 20,
        duration = 60,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 524)
end

return entity
