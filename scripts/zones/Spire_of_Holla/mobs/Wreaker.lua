-----------------------------------
-- Area: Spire of Holla
--  Mob: Wreaker
-----------------------------------
mixins = { require("scripts/mixins/families/empty_terroanima") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:addMod(xi.mod.DEFP, 35)
    mob:setMod(xi.mod.STORETP, 100)
    mob:setSpeed(50)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() <= 35 then
        mob:setMod(xi.mod.STORETP, 250)
        -- Only uses Trinary Absorption and Shadow Spread at low HP
        mob:setMobMod(xi.mobMod.SKILL_LIST, 698)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
