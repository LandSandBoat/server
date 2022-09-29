-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Moblin Fantocciniman
-- ENM: Pulling the Strings
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
end

entity.onMobEngaged = function(mob, target)
    mob:SetAutoAttackEnabled(false)
    mob:setMod(xi.mod.REGAIN, 250)
    -- Show chat
end

entity.onMobFight = function(mob, target)
    if mob:getHP() < mob:getMaxHP() then
        mob:SetAutoAttackEnabled(true)
        mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
        mob:setBehaviour(0)
    end
end

entity.onMobDeath = function(mob)
    for i= 0, 4 do
        local npc = GetMobByID(ID.mob.FANTOCCINI[mob:getBattlefield():getArea()] + i)
        if npc:isSpawned() then
            npc:addStatusEffect(xi.effect.TERROR, 0, 0, 900)
        end
    end
end

return entity
