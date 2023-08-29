-----------------------------------
-- Area: Balga's Dais
--  Mob: Opo-opo Monarch
-- BCNM: Royal Succession
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local partner = (mob:getID() + 1)
    if GetMobByID(partner):isDead() and mob:getLocalVar('buffed') == 0 then
        mob:setLocalVar('buffed', 1)
        mob:addHP(mob:getMaxHP() / 2)
        mob:addMod(xi.mod.ATT, 500)

        if math.random(1, 2) == 2 then
            mob:addMod(xi.mod.UDMGPHYS, -10000)
            mob:addMod(xi.mod.UDMGRANGE, -10000)
        else
            mob:setMod(xi.mod.UDMGMAGIC, -10000)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
