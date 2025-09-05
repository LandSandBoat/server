-----------------------------------
-- Area: Meriphataud Mountains
--   NM: Patripatan
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  559.000, y = -31.000, z =  590.000 },
    { x =  541.000, y = -32.000, z =  618.000 },
    { x =  645.000, y = -27.000, z =  658.000 }
}

entity.phList =
{
    [ID.mob.PATRIPATAN - 5] = ID.mob.PATRIPATAN, -- 551.767, -32.570, 590.205
    [ID.mob.PATRIPATAN - 4] = ID.mob.PATRIPATAN, -- 646.199, -24.483, 644.477
    [ID.mob.PATRIPATAN - 3] = ID.mob.PATRIPATAN, -- 535.318, -32.179, 602.055
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10) -- "Noted Double Attack"
    mob:addMod(xi.mod.REGAIN, 50) -- "fairly potent Regain effect"
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 269)
    xi.regime.checkRegime(player, mob, 63, 1, xi.regime.type.FIELDS)
end

return entity
