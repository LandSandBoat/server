-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Seiryu
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CANNOT_GUARD, 1)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 2):setAnimation(xi.anim.CLOSE_DOOR)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 1500)
    mob:setMobMod(xi.mobMod.GIL_MAX, 30000)
end

entity.onMobMagicPrepare = function(mob, target, spellId)
    if not mob:hasStatusEffect(xi.effect.HUNDRED_FISTS, 0) then
        local rnd = math.random(1, 100)
        if rnd <= 50 then
            return 186 -- aeroga 3
        elseif rnd <= 70 then
            return 157 -- aero 4
        elseif rnd <= 90 then
            return 208 -- tornado
        else
            return 237 -- choke
        end
    end

    return 0 -- Still need a return, so use 0 when not casting
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO)
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 10)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 2):setAnimation(xi.anim.OPEN_DOOR)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 2):setAnimation(xi.anim.OPEN_DOOR)
end

return entity
