-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Genbu
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
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 8)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 11)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.COUNTER, 20)
    mob:setMod(xi.mod.VIT, 76)
    mob:setMod(xi.mod.DEFP, 30)
end

entity.onMobSpawn = function(mob)
    mob:messageText(mob, ID.text.SKY_GOD_OFFSET + 5) -- Spawn message
    GetNPCByID(ID.npc.PORTAL_OFFSET + 5):setAnimation(xi.anim.CLOSE_DOOR)
    mob:setLocalVar('defaultATT', mob:getMod(xi.mod.ATT))
end

entity.onMobFight = function(mob, target)
    -- Gains +10 attack per 1% HP lost
    local hp = mob:getHPP()
    local power = (100 - hp) * 10

    mob:setMod(xi.mod.ATT, mob:getLocalVar('defaultATT') + power)

    -- Gains regain below 50%
    if mob:getHPP() < 50 then
        mob:setMod(xi.mod.REGAIN, 80)
    else
        mob:setMod(xi.mod.REGAIN, 0)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER)
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 6)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 5):setAnimation(xi.anim.OPEN_DOOR)
end

return entity
