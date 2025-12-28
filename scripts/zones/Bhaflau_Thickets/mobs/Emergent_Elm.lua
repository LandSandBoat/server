-----------------------------------
-- Area: Bhaflau Thickets
--   NM: Emergent Elm
-- !pos 71.000 -33.000 627.000 52
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_THICKETS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.EMERGENT_ELM - 2] = ID.mob.EMERGENT_ELM, -- 86.000 -35.000 621.000
}

entity.spawnPoints =
{
    { x = 53.502,  y = -36.250, z = 643.045 },
    { x = 54.380,  y = -36.334, z = 636.165 },
    { x = 55.477,  y = -34.969, z = 627.564 },
    { x = 57.441,  y = -34.461, z = 618.680 },
    { x = 56.988,  y = -35.349, z = 609.919 },
    { x = 66.353,  y = -35.129, z = 609.604 },
    { x = 65.786,  y = -34.000, z = 619.123 },
    { x = 65.536,  y = -33.814, z = 628.490 },
    { x = 66.826,  y = -34.000, z = 636.625 },
    { x = 67.882,  y = -34.089, z = 643.794 },
    { x = 79.049,  y = -32.000, z = 642.263 },
    { x = 81.527,  y = -32.127, z = 635.030 },
    { x = 81.290,  y = -33.569, z = 629.307 },
    { x = 79.150,  y = -36.027, z = 617.262 },
    { x = 89.760,  y = -36.250, z = 616.662 },
    { x = 93.696,  y = -35.500, z = 624.091 },
    { x = 89.406,  y = -33.943, z = 630.100 },
    { x = 86.597,  y = -32.330, z = 636.408 },
    { x = 95.099,  y = -34.000, z = 642.372 },
    { x = 104.481, y = -36.250, z = 638.963 },
    { x = 103.856, y = -35.500, z = 632.055 },
    { x = 103.465, y = -35.500, z = 627.737 },
    { x = 97.686,  y = -35.500, z = 625.171 },
    { x = 96.366,  y = -35.500, z = 628.378 },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.BIND, { chance = 10, duration = 90 })
end

entity.onMobFight = function(mob, target)
    -- mob has a regen and regain effect during the day
    local totd = VanadielTOTD()
    if totd == xi.time.NIGHT or totd == xi.time.MIDNIGHT then
        mob:setMod(xi.mod.REGEN, 0)
        mob:setMod(xi.mod.REGAIN, 0)
    else
        mob:setMod(xi.mod.REGEN, 100)
        mob:setMod(xi.mod.REGAIN, 150)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 452)
end

return entity
