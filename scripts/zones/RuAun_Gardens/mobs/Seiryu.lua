-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Seiryu
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
    mob:setMobMod(xi.mobMod.CANNOT_GUARD, 1)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 34)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
end

entity.onMobSpawn = function(mob)
    mob:messageText(mob, ID.text.SKY_GOD_OFFSET + 9) -- Spawn message
    GetNPCByID(ID.npc.PORTAL_OFFSET + 2):setAnimation(xi.anim.CLOSE_DOOR)
    mob:setMod(xi.mod.REGAIN, 450) -- Uses TP move every 20 seconds

    -- Sky gods wait 10 seconds after spawning to start casting
    mob:setMagicCastingEnabled(false)
    mob:timer(math.random(5000, 10000), function(mobArg)
        if mobArg then
            mobArg:setMagicCastingEnabled(true)
        end
    end)

    mob:addListener('EFFECT_LOSE', 'SEIRYU_HF', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.HUNDRED_FISTS then
            mobArg:setMagicCastingEnabled(true)
            mobArg:setMobAbilityEnabled(true)
        end
    end)
end

entity.onMobFight = function(mob, target)
    -- Increases to TP move usage every 9 seconds post 50% health
    if mob:getHPP() < 50 then
        mob:setMod(xi.mod.REGAIN, 700)
    else
        mob:setMod(xi.mod.REGAIN, 450)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == xi.jsa.HUNDRED_FISTS then
        mob:setMagicCastingEnabled(false)
        mob:setMobAbilityEnabled(false)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO)
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 10)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 2):setAnimation(xi.anim.OPEN_DOOR)
end

return entity
