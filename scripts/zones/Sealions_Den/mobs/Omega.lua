-----------------------------------
-- Area: Sealions Den
--  Mob: Omega
-----------------------------------
local ID = require("scripts/zones/Sealions_Den/IDs")
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
end

entity.onMobFight = function(mob, target)
    -- Gains regain at under 25% HP
    if mob:getHPP() < 25 and not mob:hasStatusEffect(xi.effect.REGAIN) then
        mob:addStatusEffect(xi.effect.REGAIN, 5, 3, 0)
        mob:getStatusEffect(xi.effect.REGAIN):setFlag(xi.effectFlag.DEATH)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.OMEGA_OSTRACIZER)
    player:startEvent(11)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 11 then
        local inst = player:getBattlefield():getArea()

        if inst >= 1 and inst <= 3 then
            -- players are healed in between fights, but their TP is set to 0
            player:setHP(player:getMaxHP())
            player:setMP(player:getMaxMP())
            player:setTP(0)
            player:setLocalVar("[OTBF]cs", 2)

            -- move player to instance
            if inst == 1 then
                player:setPos(-779, -103, -80)
            elseif inst == 2 then
                player:setPos(-140, -23, -440)
            elseif inst == 3 then
                player:setPos(499, 56, -802)
            end
        end
    end
end

return entity
