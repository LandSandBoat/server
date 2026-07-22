-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Suzaku
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MODIFIER, 30)
    mob:setMod(xi.mod.DEFP, 15)
    mob:setMod(xi.mod.ATTP, 20)
    mob:setMod(xi.mod.VIT, 75)
    mob:setMod(xi.mod.EVA, 30)
end

entity.onMobSpawn = function(mob)
    mob:messageText(mob, ID.text.SKY_GOD_OFFSET + 7) -- Spawn message
    GetNPCByID(ID.npc.PORTAL_OFFSET + 11):setAnimation(xi.animation.CLOSE_DOOR)

    mob:setMod(xi.mod.PARALYZE_RES_RANK, 4)
    mob:setMod(xi.mod.SLOW_RES_RANK, 4)
    mob:setMod(xi.mod.BLIND_RES_RANK, 4)
    mob:setMod(xi.mod.POISON_RES_RANK, -2)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 10)
    mob:setMod(xi.mod.BIND_RES_RANK, 10)

    mob:setMod(xi.mod.DARK_RES_RANK, 4)
    mob:setMod(xi.mod.LIGHT_RES_RANK, 4)
    mob:setMod(xi.mod.EARTH_RES_RANK, 4)
    mob:setMod(xi.mod.WATER_RES_RANK, -2)
    mob:setMod(xi.mod.WIND_RES_RANK, 4)
    mob:setMod(xi.mod.FIRE_RES_RANK, 10)
    mob:setMod(xi.mod.ICE_RES_RANK, 10)
    mob:setMod(xi.mod.THUNDER_RES_RANK, 4)

    -- Sky gods wait 5-10 seconds after spawning to start casting
    mob:setMagicCastingEnabled(false)
    mob:timer(math.randomInt(5000, 10000), function(mobArg)
        if mobArg then
            mobArg:setMagicCastingEnabled(true)
        end
    end)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 100,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.FIRE,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 8)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 11):setAnimation(xi.animation.OPEN_DOOR)
end

return entity
