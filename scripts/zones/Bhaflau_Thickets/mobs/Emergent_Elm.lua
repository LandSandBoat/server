-----------------------------------
-- Area: Bhaflau Thickets
--   NM: Emergent Elm
-- !pos 71.000 -33.000 627.000 52
-----------------------------------
---@type TMobEntity
local entity = {}

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
