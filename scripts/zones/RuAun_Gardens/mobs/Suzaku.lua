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
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 30)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 11)
    mob:setMod(xi.mod.DEFP, 15)
    mob:setMod(xi.mod.ATTP, 20)
    mob:setMod(xi.mod.VIT, 75)
    mob:setMod(xi.mod.EVA, 30)
end

entity.onMobSpawn = function(mob)
    mob:messageText(mob, ID.text.SKY_GOD_OFFSET + 7) -- Spawn message
    GetNPCByID(ID.npc.PORTAL_OFFSET + 11):setAnimation(xi.anim.CLOSE_DOOR)

    -- Sky gods wait 5-10 seconds after spawning to start casting
    mob:setMagicCastingEnabled(false)
    mob:timer(math.random(5000, 10000), function(mobArg)
        if mobArg then
            mobArg:setMagicCastingEnabled(true)
        end
    end)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE)
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 8)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 11):setAnimation(xi.anim.OPEN_DOOR)
end

return entity
