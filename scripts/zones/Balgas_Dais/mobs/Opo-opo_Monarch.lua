-----------------------------------
-- Area: Balga's Dais
--  Mob: Opo-opo Monarch
-- BCNM: Royal Succession
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local partner = (mob:getID() + 1)
    if (GetMobByID(partner):isDead() and mob:getLocalVar("buffed") == 0) then
        mob:setLocalVar("buffed", 1)
        mob:addHP(mob:getMaxHP()/2)
        mob:addMod(xi.mod.ATT, 500)
        if(math.random(2)==2) then
            mob:addMod(xi.mod.UDMGPHYS, -100)
            mob:addMod(xi.mod.UDMGRANGE, -100)
        else
            mob:setMod(xi.mod.UDMGMAGIC, -100)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
