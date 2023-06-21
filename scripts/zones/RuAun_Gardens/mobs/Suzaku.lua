-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Suzaku
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob, target)
    GetNPCByID(ID.npc.PORTAL_TO_SUZAKU):setAnimation(xi.anim.CLOSE_DOOR)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

-- Return the selected spell ID.
entity.onMobMagicPrepare = function(mob, target, spellId)
    -- Suzaku uses     Burn, Fire IV, Firaga III, Flare
    -- Let's give -ga3 a higher distribution than the others.
    local rnd = math.random()

    if rnd < 0.5 then
        return 176 -- firaga 3
    elseif rnd < 0.7 then
        return 147 -- fire 4
    elseif rnd < 0.9 then
        return 204 -- flare
    else
        return 235 -- burn
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE)
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 8)
    GetNPCByID(ID.npc.PORTAL_TO_SUZAKU):setAnimation(xi.anim.OPEN_DOOR)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_TO_SUZAKU):setAnimation(xi.anim.OPEN_DOOR)
end

return entity
