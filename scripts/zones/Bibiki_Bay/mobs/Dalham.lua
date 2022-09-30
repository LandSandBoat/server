-----------------------------------
-- Area: Bibiki Bay
--   NM: Dalham
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.WATER_ABSORB, 100)
end

entity.onMobFight = function(mob, target)
    -- "Increases swings per attack round as its HP lowers. At 15-20% swings like Charybdis giving the illusion of Hundred Fists."
    local swings = 1 + math.floor((100 - mob:getHPP()) / 18)
    mob:setMobMod(xi.mobMod.MULTI_HIT, swings)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
