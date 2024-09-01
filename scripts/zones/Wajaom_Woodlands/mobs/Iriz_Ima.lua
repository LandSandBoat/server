-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Iriz Ima
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.rage, { rageTimer = utils.minutes(60) })
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('BreakChance', 5)
end

entity.onCriticalHit = function(mob, attacker)
    if math.random(100) <= mob:getLocalVar('BreakChance') then
        local animationSub = mob:getAnimationSub()
        if animationSub == 4 then
            mob:setAnimationSub(1) -- 1 horn broken
        elseif animationSub == 1 then
            mob:setAnimationSub(2) -- both horns broken
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
