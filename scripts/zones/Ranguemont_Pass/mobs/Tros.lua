-----------------------------------
-- Area: Ranguemont Pass
--   NM: Tros
-- Used in Quests: Painful Memory
-- !pos -289 -45 212 166
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STORETP, 125) -- 6 hits to 1k tp
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 10)

    mob:setMod(xi.mod.SLASH_SDT, -4000) -- Takes significantly reduced physical damage
    mob:setMod(xi.mod.PIERCE_SDT, -4000)
    mob:setMod(xi.mod.IMPACT_SDT, -4000)
    mob:setMod(xi.mod.HTH_SDT, -4000)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 20,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WATER,
        basePower      = math.random(150, 200),
        actorStat      = xi.mod.INT,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

return entity
